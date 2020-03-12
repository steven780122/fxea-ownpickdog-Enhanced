string getPeriodDesc(int fPeriod) export
{
 string fPeriodToStr="";
 switch(fPeriod)
 {
  case PERIOD_M5 :  fPeriodToStr="M5";  break;
  case PERIOD_M15 : fPeriodToStr="M15"; break;
  case PERIOD_M30 : fPeriodToStr="M30"; break;
  case PERIOD_H1 :  fPeriodToStr="H1";  break;
  case PERIOD_H4 :  fPeriodToStr="H4";  break;
  case PERIOD_D1 :  fPeriodToStr="D1";  break;
  case PERIOD_W1 :  fPeriodToStr="W1";  break;
  case PERIOD_MN1 : fPeriodToStr="MN";  break;
  case PERIOD_H2 :  fPeriodToStr="H2";  break;
  case PERIOD_H3 :  fPeriodToStr="H3";  break;
  case PERIOD_H6 :  fPeriodToStr="H6";  break;
  case PERIOD_H8 :  fPeriodToStr="H8";  break;
  case PERIOD_H12 : fPeriodToStr="H12"; break;
  case PERIOD_M1 :  fPeriodToStr="M1";  break;
  case PERIOD_M2 :  fPeriodToStr="M2";  break;
  case PERIOD_M3 :  fPeriodToStr="M3";  break;
  case PERIOD_M4 :  fPeriodToStr="M4";  break;
  case PERIOD_M6 :  fPeriodToStr="M6";  break;
  case PERIOD_M10 : fPeriodToStr="M10"; break;
  case PERIOD_M12 : fPeriodToStr="M12"; break;
  case PERIOD_M20 : fPeriodToStr="M20"; break;
 }
 return(fPeriodToStr);
}