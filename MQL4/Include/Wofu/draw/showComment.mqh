#include <Wofu\\process\\GlobalVar.mqh>
void showComment(string fMode) export
{
   #ifdef SHOW_COMMENT_DISABLE
      return;
   #endif
   static string TickCommentTail=".";
        if(fMode=="InitB") Comment(EACode+" is initialing...");
   else if(fMode=="InitE") Comment(EACode+" is initialed. Waiting for a tick...");
   else if(fMode=="InitF") Comment(EACode+" is failed.");
   else if(fMode=="Tick")
   {
         
         Comment(EACode+" is working"+TickCommentTail);
         TickCommentTail+=".";
         if(TickCommentTail==".......")TickCommentTail=".";
   }
}


#ifdef OLD_ALIAS
   void ShowComment(string fMode) export
   {  showComment( fMode); }
#endif 
