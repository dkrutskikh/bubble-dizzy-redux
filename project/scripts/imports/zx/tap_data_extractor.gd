# Детали описания формата https://github.com/Oleg-N-Cher/MakeZX/blob/master/Docu/TAP%20file%20format.txt

class_name TapDataExtractor

var fileName:String;
var content:PackedByteArray;

var _loadingScreen:PackedByteArray;

func _init(path:String):
  var file := FileAccess.open(path, FileAccess.READ);

  var headerBlock := _readBlock(file);
  var block1 := _readBlock(file);
  _loadingScreen = _readBlock(file);
  var block3 := _readBlock(file);
  var block4 := _readBlock(file);

  # всегда 0. Байт, указывающий стандартный заголовок загрузки ПЗУ
  var headerFlag := headerBlock[0];
  # всегда 0. Байт, указывающий заголовок программы (0 - бейсик программа, 1 - числовой массив, 2 - символьный массив, 3 - кодовый блок)
  var headerDataType := headerBlock[1];
  # загружаемое имя программы (заполнено пробелами)
  var headerFileName := headerBlock.slice(2, 12).get_string_from_ascii();
  # длина блока данных, следующего за заголовком (без флагового байта и байта контрольной суммы)
  # длина следующих данных (после заголовка) = длина программы BASIC + переменные
  var headerDataLength := headerBlock[12] + headerBlock[13] * 256;
  # Параметр LINE команды SAVE. Значение 32768 означает "нет автозагрузки"; 0..9999 — допустимые номера строк.
  # Параметр для Бейсик-программы - номер стартовой строки Бейсик-программы, заданный параметром LINE (или число >=32768, если стартовая строка не была задана. Для кодового блока - начальный адрес блока в памяти. Для массивов данных - 14й-байт хранит односимвольное имя массива
  var headerAutostartLine := headerBlock[14] + headerBlock[15] * 256;
  # длина программы BASIC; оставшиеся байты ([длина данных] - [длина программы]) = смещение переменных
  # Для Бейсик-программы - хранит размер собственно Бейсик-програмы, без инициализированных переменных, хранящихся в памяти на момент записи Бейсик-программы. Для остальных блоков содержимое этого параметра не значимо, и я почти уверен, что это не два байта ПЗУ. Скорее всего, они просто не инициализируются при записи
  var headerProgramLength := headerBlock[16] + headerBlock[17] * 256;

  var contentLength := file.get_length();
  content = file.get_buffer(contentLength-19-2);
  file.close();

func _readBlock(file:FileAccess) -> PackedByteArray:
  var blockSize := file.get_16();

  var data := file.get_buffer(blockSize - 1);
  var crc := file.get_8();

  return data;

func loadingImage() -> Image:

  var imageData := PackedByteArray([]);
  imageData.resize(256*192*4);

  for y in 192:
    for x in 256:
      var pixelIndex := y * 256 + x;

      var pixelByteIndex := (((y / 64) & 3) * 2048) + (((y / 8) & 7) * 32) + ((y & 7) * 256) + x / 8 + 1;
      var pixelBit := 128 >> (x & 7);

      var attributeByteIndex := y / 8 * 32 + x / 8 + 1 + 6144;
      var attribute := _loadingScreen[attributeByteIndex];
      var brightnes := 255 if ((attribute & 64) != 0) else 224;

      var r := ((attribute >> 4) & 1) * brightnes;
      var g := ((attribute >> 5) & 1) * brightnes;
      var b := ((attribute >> 3) & 1) * brightnes;

      if ((_loadingScreen[pixelByteIndex] & pixelBit) != 0):
        r = ((attribute >> 1) & 1) * brightnes;
        g = ((attribute >> 2) & 1) * brightnes;
        b = ((attribute >> 0) & 1) * brightnes;

      imageData.set(pixelIndex * 4 + 0, r);
      imageData.set(pixelIndex * 4 + 1, g);
      imageData.set(pixelIndex * 4 + 2, b);
      imageData.set(pixelIndex * 4 + 3, 255);

  return Image.create_from_data(256, 192, false, Image.FORMAT_RGBA8, imageData);
