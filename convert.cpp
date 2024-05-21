#include <iostream>
#include <string>
#include <vector> // introduced in chapter 4
#include <cstdlib>
#include <cassert>
#include <list>
#include <queue>
#include <cctype>
#include <unordered_map>
#include <limits>
#include <iomanip>
#include <stdexcept>


using namespace std;

void log(const string& message)
{
	cout << "[LOG] " << message << endl;
}

				double countAndConvert(bool hasDollarBills) 
				{
					    int pennies, nickels, dimes, quarters;
						
						log("Starting countAndConvert function");
						
						assert(pennies >= 0);
						// Ensure pennies are non-negative
						assert(nickels >= 0);
						// Ensure nickels are non-negative 
						assert(dimes >= 0);
						// Ensure dimes are non-negative 
						assert(quarters >=0);
						// Ensure quarters are non-negative 
						
						cout << "How many pennies do you have? ";
						
						cin >> pennies;
						
						log("User entered pennies: " + to_string(pennies));
						
						cout << "How many nickels do you have? ";
						
						cin >> nickels;
						
						log("User entered nickels: " + to_string(nickels));
						
						cout << "How many dimes do you have? ";
						
						cin >> dimes;
						
						log("User entered dimes: " + to_string(dimes));
						
						cout << "How many quarters do you have? ";
						
						cin >> quarters;
						
						log("User entered dimes: " + to_string(quarters));
						
						double total = pennies * 0.01 + nickels * 0.05 + dimes * 0.1 + quarters * 0.25
					
					// Chapter 2 work
					
					if (hasDollarBills) 
					{
 
					
						int onedollar, fivedollar, tendollar, twentydollars;
						
						assert(onedollar >= 0);
						// Ensure one dollar bills are non-negative
						assert(fivedollar >= 0);
						// Ensure five dollar bills are non-negative
						assert(tendollar >= 0); 
						// Ensure ten dollar bills are non-negative
						assert(twentydollars >= 0);
						// Ensure twenty dollar bills are non-negative
    }
						
						cout << "How many one dollar bills do you have? ";
						
						cin >> onedollar;
						
						log("User entered one dollar bills: " + to_string(onedollar));
						
						cout << "How many five dollar bills do you have? ";
						
						cin >> fivedollar;
						
						log("User entered five dollar bills: " + to_string(fivedollar));
						
						cout << "How many 10 dollar bills do you have? ";
						
						cin >> tendollar;
						
						log("User entered ten dollar bills: " + to_string(tendollar));
						
						cout << "How many 20 dollar bills do you have? ";
						
						cin >> twentydollars;
						
						log("User entered twenty dollar bills: " + to_string(twentydollars));
								
									total += onedollar * 1.0 + fivedollar * 5.0 + tendollar * 10.0 + twentydollars * 20.0; 
									//Total Value
					}
					
					
							
						cout <<"Total Value = " << total << "\n";
						

					// Chapter 3 work
					
						cout <<"Which type of currency you would like to convert to? Yen, Euro, or Ruble (case sensitive):  ";
						
						string currency;
						
						cin >>currency;
						
						log("User selected currency: " + currency);
						
							if (currency == "Yen")
							{
								double JPY = total * 147.90972;
								// current exchange rate of yen 9.17.23
							cout <<"Yen conversion is = " << JPY << "\n";	
							}
						
							else if (currency == "Euro")
							{
								double EUR = total * 0.93825615;
								// current exchange rate of EUR 9.17.23
							cout <<"Euro conversion is = " <<EUR << "\n";
							}
							
							else if (currency == "Ruble")
							{
								double RUB = total * 96.749783;
								// current exchange rate of RUB 9.17.23
							cout <<"Ruble conversion is = " << RUB << "\n";
							}
						

						cout <<"Thank you, please use me again.";
						log("Exiting countAndConvert function");
						return total;
				}


				// Function to find the minimum value in an array
				// This is going to be used for the coding to calculate the race times.
				double minimum(const double a[], int a_size) 
				{
					if (a_size == 0) 
					{
						return 0;
					}

					double lowest = a[0];

					for (int i = 1; i < a_size; i++) 
					{
						if (a[i] < lowest) 
						{
							lowest = a[i];
						}
					}

					return lowest;
				}
				// Function to read data into an array
				void read_data(double a[], int a_capacity, int& a_size) 
				{
					a_size = 0;
					
					bool more = true;

					while (more) 
					{
						double x;
						
						cin >> x;

						if (x == 0) 
						{
							more = false;
						} 
						else if (a_size == a_capacity) 
						{
							cout << "Invalid entry - entry ignored\n";
							
							more = false;
						} 
						else 
						{
							a[a_size] = x;
							
							a_size++;
						}
					}
				}
				// Function to read race times and find the minimum
				void time() 
				{
					const int RACE_TIME = 100;
					
					double race_times[RACE_TIME];
					
					int race_size = 0;

					cout << "Time your races!\n";
					
					cout << "Please enter your race times in whole seconds, 0 to quit:\n";

					read_data(race_times, RACE_TIME, race_size);

					double min_time = minimum(race_times, race_size);
					
					cout << "The fastest time is " << min_time << "\n";
				}

				// The following code takes the input from the user of the names of classmates and prints them all out alphabetically
				class ClassMates 
				{

					public:
						string name;
						ClassMates* next;
						
						ClassMates(const string& n) : name(n), next(nullptr) {}
				};
				class ClassList 
				{
					private:
						ClassMates* head;

					public:
						ClassList() : head(nullptr) {}
						
						~ClassList() 
						{
							while (head != nullptr) 
							{
								ClassMates* temp = head;
								
								head = head->next;
								
								delete temp;
								// Deconstructor here deallocates memory for the linked list nodes when Classlist goes out of scope.
							}
						}

						void addClassMates(const string& name) 
						{
							ClassMates* newClassMates = new ClassMates(name);
							
							newClassMates->next = head;
							
							head = newClassMates;
						}

						void displayClassMates() 
						{
							ClassMates* current = head;
							
							cout << "Class List:\n";
							
							while (current != nullptr) 
							{
								cout << current->name << "\n";
								
								current = current->next;
							}
						}
					};
					
int main() 
{
	int choice;
	
	bool program = true;
	
	log("Program started");
	
	while (program) 
	{
		/* Using Case to make it simple to combine multiple layers of code into a single program that does many different things. cases make this a really simple task **/
		cout << "Which program would you like to run?\n";
		
		cout << "1 - Count and Convert \n"; 
		
		/* This program is going to cover everything from the first assignment modules 1-3 **/
		cout << "2 - Fastest Race Time \n";
		
		/* This program covers the topics from Chapter 6 **/
		cout << "3 - Classmates \n";
		
		/* This program is seeking to cover lists as learned in chapter 12 **/
		cout << "4 - Chore priorities \n";
		
		/* This program will cover priority queues **/
		cout << "5 - Grocery List \n";
		
		cout << "Enter your choice and press Enter: ";
		
		try 
		{
			
			cin >> choice;
				if (cin.fail()) 
				{
					cin.clear();
					cin.ignore(numeric_limits<streamsize>::max(), '\n');
					throw invalid_argument("Invalid input for choice.");
				}
		
			switch (choice)
			{
				
			case 1:
			{
				
			countAndConvert(true);
			// Call with true to indicate dollar bills.
			
			break;

			}			
			
			case 2:
			{

				
                const int RACE_TIME = 100;
				
                double race_times[RACE_TIME];
				
                int race_size = 0;
				
				cout << "Time your races!\n";

                cout << "Please enter your race times in whole seconds, 0 to quit:\n";

                read_data(race_times, RACE_TIME, race_size);

                double min_time = minimum(race_times, race_size);
				
				assert(race_size >= 0 && race_size <= RACE_TIME);
				// ensure race_size is within a valid range
				
                cout << "The fastest time is " << min_time << " seconds \n";
			
                break;
            } 
				
			case 3:
			{
				ClassList classmatesList; // Create an instance of ClassList
				
				cout << "Enter the names of classmates (type 'quit' to stop):\n";
				
				string name;

				while (true) 
				{
					cin >> name;
					
					if (name == "quit") 
					{
						break;
					}
					classmatesList.addClassMates(name);
				}

				cout << "Classmates List:\n";
				
				classmatesList.displayClassMates();
			
				break;
			}
			
			case 4:
			{
				cout << "Chores \n";
				
				// Defines the struct to represent a chore
				struct Chore
				{
					std::string name;
					
					int priority;
					
					// Overload the operator based on the little bit of overload info we covered in chapter 13
					bool operator<(const Chore& other) const
					// when a 'Chore' is created its constructor sets the inital state.
					{
						// this makes higher priority chores come first
						return priority < other.priority;
					}
				};
				
				int chores;
				{
					//create a priority queue of chores
					std::priority_queue<Chore> choreQueue;
					
					while (true)
					{
						std::cout << "Enter chore name (or 'quit' to exit): ";
						
						std::string choreName;
						
						std::cin >> choreName;
						
						if (choreName == "quit")
						{
							break;
						}
						
						std::cout << "Enter chore priority (1 being low priority and increasing in priority from there): ";
						
						int chorePriority;
						
						std::cin >> chorePriority;
						
						//create a chore object and push it into the queue
						Chore chore = {choreName, chorePriority};
						
						choreQueue.push(chore);
						
						std::cout << "Chore '" << choreName << "' with priority " << chorePriority << " added. \n";
					}
					
					std::cout << "\nChores to do:\n";
					
					//Process and display chores in order of priority (highest first)
					
					while (!choreQueue.empty())
					{
						Chore chore = choreQueue.top();
						
						choreQueue.pop();
						
						std::cout << "Chore: " << chore.name << " (Priority: " << chore.priority << ")\n";
						
					}
					
					return 0;
				}
			
			break;
			}
			
			case 5:
			{
				// Hash is unordered_map named groceryList to store items as the key and qty as the value.
				unordered_map<string, int> groceryList;

					cout << "Grocery List:\n";
					
					bool continueAdding = true;

					while (continueAdding) 
					{
						string item;
						
						int quantity;

						cout << "Enter an item (or 'quit' to finish): ";
						
						cin.ignore();
						
						getline(cin, item);
						
						//this read the full line as the item - if I just used cin it would break the code if you used multiple words
						// Stores the item in the hash

						if (item == "quit") 
						{
							continueAdding = false;
						} 
						else 
						{
							bool validQuantity = false;
							
							while (!validQuantity)
							{
								cout << "Enter the quantity: ";
								
								try
								{
									cin >> quantity;
									if (cin.fail())
									{
										throw runtime_error("Invalid input for quantity.");
									}
								
									validQuantity = true;
								}
									catch (const runtime_error &e)
									{
										cerr << e.what() << endl;
										cin.clear();
										cin.ignore(numeric_limits<streamsize>::max(), '\n');
										// this handles the error and asks the user to retry the quantity
									}
							}
							if (item != "quit")
							{
								// Stores the item in the hash
								groceryList[item] = quantity;
							}
							else
							{
								continueAdding = false;
							}

						}
					
					}

					cout << "\nYour Grocery List:\n";
					
					for (const auto& item : groceryList) 
					{
						cout << item.first << ": " << item.second << " unit(s)\n";
					}
			
					break;
			}
			
			default:
				cout << "Invalid choice. Please enter a valid choice. \n";
				break;
		}
				

				
		}
		
		
			catch (const invalid_argument &e)
			{
				cerr << e.what() << endl; 
				
				// handles the error, asking the user to enter the choice again.
			}
			
        // Check if the user wants to continue or return to the main menu
        cout << "Do you want to return to the main menu? (1 for Yes, 0 for No): ";
        cin >> program;

        if (!cin)
        {
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cerr << "Invalid input for program choice. Returning to the main menu.\n";
            program = true;  // Return to the main menu on invalid input
        }
		else if (program)
		{
			cout << "Returning to the main menu. \n";
		}
    }

	log("Program ended...");
    return 0;
}