//#include <Wofu\\common\\cryptDecodeFromFile.mqh>


/*
https://docs.mql4.com/constants/namedconstants/otherconstants#enum_crypt_method
CRYPT_BASE64
BASE64
CRYPT_AES128
CRYPT_AES256
CRYPT_DES
CRYPT_HASH_SHA1
CRYPT_HASH_SHA256
CRYPT_HASH_MD5
CRYPT_ARCH_ZIP
*/

bool cryptDecodeFromFile(ENUM_CRYPT_METHOD cipher, string strKey, string strDataFileName, string & strResult)
{
   strResult = "";
   uchar arrKey[];
   StringToCharArray(strKey, arrKey);
   // Read the encrypted data back from the file 
   uchar arrFileData[];
   int fRead = FileOpen(strDataFileName, FILE_READ | FILE_BIN);
   if (fRead == INVALID_HANDLE) {Print("Unable to open file for reading");return false;}
   FileReadArray(fRead, arrFileData);
   FileClose(fRead);
   
   // Decrypt the data 
   uchar arrDecryptedData[];
   int szDec = CryptDecode(cipher, arrFileData, arrKey, arrDecryptedData);
   if (szDec <= 0) {Print("CryptDecode failed");return false;}
   
   // Convert the decrypted data back from an array to a string, and pass back by reference
   strResult = CharArrayToString(arrDecryptedData);
   return true;
}

