#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <map>
#include "mex.h"

using namespace std;

class Node
{
public:
    int symbol;
    double probability;

    Node *left, *right;

    Node(int symbol, double probability)
    {
        this->symbol = symbol;
        this->probability = probability;
        this->left = NULL;
        this->right = NULL;

    }

};
class Compare {
public:

    bool operator()(Node *left, Node *right)
    {
        return (left->probability >= right->probability);

    };
};

typedef priority_queue<Node*, vector<Node*>, Compare> Tree;
typedef map<int, string> hash_map_encode;
typedef map<string, int> hash_map_decode;

void tranverse_tree(Node* root,string str, vector<int> &symbols, vector<string> &codes)
{
    if(!root)
        return;

    if(root->symbol!=-1)
    {
        symbols.push_back(root->symbol);
        codes.push_back(str);
    }

    tranverse_tree(root->left, str+"0", symbols, codes);
    tranverse_tree(root->right,str + "1", symbols, codes);
}
Tree createHuffmanTree(vector<int> symbols, vector<double> probabilities)
{

    Tree tree;

    for(int i=0; i<probabilities.size();i++)
    {
        Node* temp = new Node(symbols[i], probabilities[i]);
        tree.push(temp);
    }

    Node *left, *right, *parent;

    while(tree.size() > 2) {

        left = tree.top();
        tree.pop();

        right = tree.top();
        tree.pop();

        double parent_prob = left->probability + right->probability;

        parent = new Node(-1, parent_prob);

        parent->left = left;
        parent->right = right;

        tree.push(parent);
    }

    if(tree.size()==2)
    {
        left = tree.top();
        tree.pop();

        right = tree.top();
        tree.pop();

        double parent_prob = left->probability + right->probability;

        parent = new Node(-1, parent_prob);

        parent->left = right;
        parent->right = left;

        tree.push(parent);
    }

    return tree;

}

vector<int> convert_to_int(vector<string> kodovi)
{
    vector<int>  result;

    for(int i=0;i<kodovi.size();i++)
    {
         result.push_back(stoi(kodovi[i], nullptr, 2));
    }

    return result;

}


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
 
    int N;
    int M;
    
    N = mxGetN(prhs[0]);
    int *A = (int *)mxGetData(prhs[0]);
    vector<int> simboli(A, A + N);

    
    M = mxGetN(prhs[1]);
    double *B = mxGetPr(prhs[1]);
    vector<double> verovatnoce(B, B + M);
    
    
    Tree temp_tree;
    temp_tree = createHuffmanTree(simboli, verovatnoce);
    
    vector<int> simbs;
    vector<string> kodovi;
    tranverse_tree(temp_tree.top(), "", simbs, kodovi);
    for(int i=0; i< simbs.size();i++)
        mexPrintf("%d =: %s \n", simbs[i], kodovi[i].c_str());
       
    
    plhs[0] = mxCreateNumericMatrix(1, N, mxINT32_CLASS, mxREAL);
    int *data_1 = (int *) mxGetData(plhs[0]);
    copy(simbs.begin(), simbs.end(), data_1);
    
    
    vector<int> kods;
    kods = convert_to_int(kodovi);
    plhs[1] = mxCreateNumericMatrix(1, N, mxINT32_CLASS, mxREAL);
    int *data_2 = (int *) mxGetData(plhs[1]);
    copy(kods.begin(), kods.end(), data_2);
    
    plhs[2] = mxCreateNumericMatrix(1, N, mxINT32_CLASS, mxREAL);
    int *data_3 = (int *) mxGetData(plhs[2]);
    
    vector<int> duzine;
    for(int i=0;i<kodovi.size();i++)
        duzine.push_back(kodovi[i].size());
    
    copy(duzine.begin(), duzine.end(), data_3);
    
    
}
