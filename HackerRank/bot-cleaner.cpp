void bot_action(int posr, int posc, vector<string> board) {   
   if (board[posr][posc] == 'd') {
      cout << "CLEAN" << endl;
      return;
   }

   int x, y;

   for (int i = 0; i < board.size(); i++) {
      for (int j = 0; j < board.size(); j++) {
         if (board[i][j] == 'd') {
            x = j;
            y = i;
            goto done;
         }
      }
   }

   done: if (posc < x) {
      cout << "RIGHT" << endl;
   } else if (posc > x) {
      cout << "LEFT" << endl;
   } else if (posr < y) {
      cout << "DOWN" << endl;
   } else if (posr > y) { // should never occur
      cout << "UP" << endl;
   }
}
