#include<iostream>
#include<string>
using namespace std;


int count = 0;
char maze[101][101];
bool visited[101][101];
bool findAnswer = false;

void dfs(int x, int y){
    count++;
    visited[x][y] = true;
    int dx[4] = { 0, 1, 0, -1};
    int dy[4] = { 1, 0, -1, 0};
    // (0, 1)  UP
    // (0, -1) DOWN 
    // (1, 0)  RIGHT
    // (-1, 0) LEFT
    for(int i=0; i<4; i++){

        if(findAnswer == true) break;

        if(x+dx[i] < 0 || y+dy[i] < 0 || x+dx[i] > 100 || y+dy[i] > 100 ) contiune;
        
        if(visited[x+dx[i]][y+dy[i]]== true) contiune;
        
        dfs(x+dx[i],y+dy[i]);
        visited[x+dx[i]][y+dy[i]] = false;
        if(maze[x + dx[i]][y+ dy[i]] == 'F') {
            findAnswer = true;
        } // 결과
        
    }
    
}

int main(){
    
    int N, M;
    //visited[0][0] = true;
    string s;
    
    cin >> N >> M;
    

    for(int i = 0; i<N; i++){
        cin >> s;
        for(int j=0; j<M; j++){
            maze[i][j] = s[j];
            //cout << maze[i][j];
        }
        //cout<<endl;
        if(i == N-1 && j== M-1){
            maze[i][j] = 'F';
        }
    }

    dfs(0,0);

    cout << count;
    
    
}