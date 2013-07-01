// Histogram with C++
//  {compile} --> g++ histogram.cpp -o histogram
//  {run}     --> ./histogram

#include <map>        // STD map
#include <string>     // STD string
#include <vector>     // STD vector

#include <iostream>   // STD I/O
#include <sstream>    // StringStream

using namespace std;

int main()
{
  /* Declare all variables for program. */

  string buffer, sentence;
  vector<string> words;

  map<string, int> get_freq;
  map<string, int>::iterator iter1;
  
  map<int, string> frequency;
  map<int, string>::reverse_iterator iter2;

  /* Setup sentence for frequency analysis. */

  sentence = "this test of is a a this test phrase of is a of a of a test";
  cout << "\nTest sentence for histogram is:\n\t" << sentence << endl;

  /* Perform string split via stringstream. */

  stringstream ss(sentence);

  while(ss >> buffer)
    words.push_back(buffer);

  /* Calculate frequency of words via the map. */

  for (int i = 0; i < words.size(); i++)
  {
    // If word does not exist, add it to the map.
    if (get_freq.find(words[i]) == get_freq.end())
      get_freq[words[i]] = 1;
    else
      get_freq[words[i]] += 1;
  }

  /* Create a second map with K-V pairs flipped so it is sorted. */

  // Set values from first map to keys of second map.
  for (iter1 = get_freq.begin(); iter1 != get_freq.end(); iter1++)
    frequency[iter1->second] = iter1->first;

  /* Print out frequency map in reverse order as "V-K" pairs in output. */

  cout << "\nFrequency table of sentence is:\n" << endl;

  for (iter2 = frequency.rbegin(); iter2 != frequency.rend(); iter2++)
    cout << iter2->second << ", count = " << iter2->first << endl;

  cout << "\nC++ program is DONE.\n" << endl;

  return 0;
}