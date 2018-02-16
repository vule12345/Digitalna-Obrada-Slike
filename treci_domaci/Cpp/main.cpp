#include <iostream>
#include "utilities.h"


using namespace std;



int main()
{
    vector<int> arr = { 1,2,3,4,5,6 };
    vector<double> freq = { 5, 9, 12, 13, 16, 45 };

    Tree temp_tree;
    temp_tree = createHuffmanTree(arr, freq);

    vector<int> simboli;

    vector<string> kodovi;

    traverse_tree(temp_tree.top(), "", simboli, kodovi);

    cout<<stoi(kodovi[2], nullptr, 2)<<endl;

    vector<int> probica = convert_to_int(kodovi);

    for(int i=0;i< kodovi.size();i++)
        cout << simboli[i] << ": " << kodovi[i] << "\n";


    hash_map_encode temp_map_encode;
    temp_map_encode = createHashMapEncode(simboli,kodovi);

    string res = encodeArray(temp_map_encode, arr);


    hash_map_decode temp_map_decode;
    temp_map_decode = createHashMapDecode(simboli,kodovi);

    vector<int> res123;
    res123 = decodeArray(temp_map_decode, res);

    for(int i=0;i<res123.size();i++)
        cout<<res123[i]<<endl;

}