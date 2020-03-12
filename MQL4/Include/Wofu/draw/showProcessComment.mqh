enum ENUM_PROCESS_COMMENT_MODE
{
   PROCESS_COMMENT_MODE_INIT_BEGIN=10,
   PROCESS_COMMENT_MODE_INIT_END=11,
   PROCESS_COMMENT_MODE_INIT_FAIL=12,
   PROCESS_COMMENT_MODE_TICK_STOP=20,
   PROCESS_COMMENT_MODE_TICK=21,

};

void showProcessComment(string eaCode,ENUM_PROCESS_COMMENT_MODE fMode) export
{
   static string TickCommentTail=".";
        if(fMode==PROCESS_COMMENT_MODE_INIT_BEGIN)Comment(eaCode+" is initialing...");
   else if(fMode==PROCESS_COMMENT_MODE_INIT_END  )Comment(eaCode+" is initialed. Waiting for a tick...");
   else if(fMode==PROCESS_COMMENT_MODE_INIT_FAIL )Comment(eaCode+" is failed.");
   else if(fMode==PROCESS_COMMENT_MODE_TICK_STOP )Comment(eaCode+" is Stopped!!!");
   else if(fMode==PROCESS_COMMENT_MODE_TICK)
   {
         Comment(eaCode+" is working"+TickCommentTail);
         TickCommentTail+=".";
         if(TickCommentTail==".......")TickCommentTail=".";
   }
}