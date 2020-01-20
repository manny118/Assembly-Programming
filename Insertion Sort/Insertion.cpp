//Author: Emmanuel Akinrintoyo
//Date: 22/11/2019
//This is a cpp program that interfaces with an assembly program to 
//sort characters entered by the user

#include "stdafx.h"
extern "C" { void  sort (char input[]  , int n  ); }
int getSize(char b[] );

int _tmain(int argc, _TCHAR* argv[])
{
	char buffer[256]; //declares an array of size 10 
	
	for(int i=0; i<256; i++){
		
		buffer[i] = 0;//initialises the characters to 0 
		
	}

	cout << "Enter some characters (256 max): ";//prompts the user for characters
	
	cin.getline(buffer, 256);//stores the input from the user
	
	int size = getSize(buffer);//stores the size of the array
	
	cout << "\nUnsorted array" << endl;

	//prints the unsorted array
	for(int i=0; i<size; i++){
		
		cout << buffer[i] << " " ; 

	}
	
	cout << "\n\nSorted array" << endl;

	sort(buffer, size);//passes in the array and its size
	
	//prints the sorted array
	for(int i=0; i<size; i++){

		cout << buffer[i] <<  " " ;

	}

	cout << "\n" ;

	return 0;
}

//checks the number of characters inputted
int getSize(char buffer[]){

	string input = "";//initialises an empty string
	for(int i=0; i<256; i++){
		
		if(buffer[i] != 0){
			input += buffer[i];
		}				
	}
	
	return input.size();
}