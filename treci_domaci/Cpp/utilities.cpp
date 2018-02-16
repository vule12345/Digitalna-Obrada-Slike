#include "utilities.h"

using namespace std;

void traverse_tree(Node *root, string str, vector<int> &symbols, vector<string> &codes)
{
    if(!root)
        return;

    if(root->symbol!=-1)
    {
        symbols.push_back(root->symbol);
        codes.push_back(str);
    }

    traverse_tree(root->left, str + "0", symbols, codes);
    traverse_tree(root->right, str + "1", symbols, codes);
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

hash_map_encode createHashMapEncode(vector<int> symbols, vector<string> codes)
{

    hash_map_encode huffman_map;

    for(int i=0; i<symbols.size(); i++ )
        huffman_map[symbols[i]] = codes[i];

    return huffman_map;
}

hash_map_decode createHashMapDecode(vector<int> symbols, vector<string> codes)
{

    hash_map_decode huffman_map;

    for(int i=0; i<symbols.size(); i++ )
        huffman_map[codes[i]] = symbols[i];

    return huffman_map;
}

string encodeArray(hash_map_encode huffman_map, vector<int> img)
{
    string result = "";

    for(int i=0;i<img.size();i++)
    {
        result += (huffman_map[img[i]]);
    }
    return result;
}
vector<int> decodeArray(hash_map_decode huffman_map, const string codded_array)
{

    vector<int> result;

    for(int i=0; i<codded_array.size();i++)
    {

        string codded_string = "";
        codded_string+= codded_array[i];

        while(huffman_map.count(codded_string)==0)
        {
            i++;
            codded_string+= codded_array[i];
        }

        result.push_back(huffman_map[codded_string]);
    }
    return result;

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