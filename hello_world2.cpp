#include <fstream>
#include <iostream>

int main(int argc, char *argv[])
{
	std::ofstream ofs ("hello.txt", std::ofstream::out);
	ofs << "Hello CS203!\n";
	ofs.close();
	std::cout << "Execution Complete" << std::endl;
	return 0;  
}
