void splitHourAndMinute(string fHM,int& fHr,int& fMn)
{
   datetime fDMHM=(datetime)fHM;
   MqlDateTime fTimestruct;
   TimeToStruct(fDMHM,fTimestruct);
   fHr=fTimestruct.hour;
   fMn=fTimestruct.min;
}