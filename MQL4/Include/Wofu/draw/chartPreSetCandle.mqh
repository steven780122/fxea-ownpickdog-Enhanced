void chartPreSetCandle(color fBull=clrBlack,color fBear=clrWhite,color fUp=clrLime,color fDown=clrLime) export
{
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,fBull);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,fBear);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,fUp);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,fDown);
} 

#ifdef OLD_ALIAS
   void ChartPreSetCandle(color fBull=clrBlack,color fBear=clrWhite,color fUp=clrLime,color fDown=clrLime) export
   {  chartPreSetCandle( fBull, fBear, fUp, fDown); }
#endif 
