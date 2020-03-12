//#include <Wofu\\common\\cryptEncodeToFile.mqh>


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

bool cryptEncodeToFile(ENUM_CRYPT_METHOD cipher, string strKey, string strUnencryptedData, string strDataFileName)
{
   // Convert the unencrypted string to a byte array
   uchar arrUnencryptedData[];
   StringToCharArray(strUnencryptedData, arrUnencryptedData);
   uchar arrKey[];
   StringToCharArray(strKey, arrKey);
   // Encrypt the raw data
   uchar arrEncryptedData[];
   int szEnc = CryptEncode(cipher, arrUnencryptedData, arrKey, arrEncryptedData);
   if (szEnc <= 0) {Print("CryptEncode failed");return false;}
   
   // Write the encrypted data to a file
   int fWrite = FileOpen(strDataFileName, FILE_WRITE | FILE_BIN);
   if (fWrite == INVALID_HANDLE) {Print("Unable to open file for writing");return false;}
   FileWriteArray(fWrite, arrEncryptedData);
   FileClose(fWrite);

   return true;
}