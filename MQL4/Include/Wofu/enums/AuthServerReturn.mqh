enum ENUM_AUTH_SERVER_RETURN
{
   
   AUTH_PROC_START=1,             //認證中....
   AUTH_FAIL_INTERNET_NOT_OPEN=10,//初始化就失敗
   AUTH_FAIL_NOT_CONNECT=11,      //連不上主機
   AUTH_FAIL_READ_ERROR=12,       //連上無法讀取網站資料
   AUTH_FAIL_DATA_ERROR=13,       //有取得資料,資料格式不對
   AUTH_FAIL_BY_RESPONSE=80,      //資料格式對,解析之後認證失敗
   AUTH_SUCCESS=89,               //資料格式對,解析之後認證成功
   AUTH_FAIL_UNKNOW=99,           
   

};