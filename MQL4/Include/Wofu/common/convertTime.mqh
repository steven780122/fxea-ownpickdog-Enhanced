//#include <Wofu\\common\\convertTime.mqh>
enum ENUM_CONVERT_TIME_MODE
{
   CONVERT_TIME_MODE_LOCAL_TO_SERVER=0,
   CONVERT_TIME_MODE_SERVER_TO_LOCAL=1,
};

datetime convertTime(datetime fTime,ENUM_CONVERT_TIME_MODE fMode)
{
   datetime DifTime=TimeLocal()-TimeCurrent();

   if(fMode==CONVERT_TIME_MODE_LOCAL_TO_SERVER)
      return( (datetime)(fTime-DifTime+MathMod((int)DifTime,60)));
   else
   if(fMode==CONVERT_TIME_MODE_SERVER_TO_LOCAL)
      return( (datetime)(fTime+DifTime+MathMod((int)DifTime,60)));
   else
      return(fTime);




}