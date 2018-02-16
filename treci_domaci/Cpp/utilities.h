//
// Created by vuk on 14.12.17..
//

#ifndef HUFFMAN_UTILITIES_H
#define HUFFMAN_UTILITIES_H

#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <map>

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

void traverse_tree(Node *root, string str, vector<int> &symbols, vector<string> &codes);

Tree createHuffmanTree(vector<int> symbols, vector<double> probabilities);

hash_map_encode createHashMapEncode(vector<int> symbols, vector<string> codes);

hash_map_decode createHashMapDecode(vector<int> symbols, vector<string> codes);

string encodeArray(hash_map_encode huffman_map, vector<int> img);

vector<int> decodeArray(hash_map_decode huffman_map, const string codded_array);

vector<int> convert_to_int(vector<string> binary);


#endif //HUFFMAN_UTILITIES_H
