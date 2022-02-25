#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include <map>
#include <string>
#include <thread>
#include <vector>

void run_deconstruct(double _start, double _end) {
    printf("Running between %f and %f\n", _start, _end);
    std::string terminal_string = "reconstructPar -time " +
                                  std::to_string(_start) + ":" +
                                  std::to_string(_end);
    printf("Passing to the terminal: \n%s \n.............\n",
           terminal_string.c_str());
    std::system(terminal_string.c_str());
}
void setParameter(std::string input,
                  std::map<std::string, double>* parameters) {
    std::string param = input.substr(0, input.find("="));
    double argument = std::atof(input.substr(input.find("=") + 1).c_str());
    std::vector<std::string> validCommands = {"n", "start", "end"};
    if (std::find(validCommands.begin(), validCommands.end(), param) !=
        validCommands.end()) {
        parameters->insert(std::pair<std::string, double>(param, argument));
    }

    if (param == "help") {
        printf("n \t number of cores\n start\t start time\n end\t end time\n");
    }
}
int main(int argc, char* argv[]) {
    std::map<std::string, double> parameters;
    for (size_t i = 0; i < argc; i++) {
        setParameter(argv[i], &parameters);
    }
    int number_of_cores = (int)parameters["n"];

    double interval =
        (parameters["end"] - parameters["start"]) / ((double)(number_of_cores));

    printf("Set to %d cores.\n", number_of_cores);
    printf("Start time = %f\t end time = %f\n\n", parameters["start"],
           parameters["end"]);

    std::vector<std::thread> threads;

    printf("starting threads\n");
    for (size_t k = 0; k < number_of_cores; k++) {
        double t1 = parameters["start"] + k * interval;
        double t2 = t1 + interval;
        threads.push_back(std::thread(run_deconstruct, t1, t2));
    }

    for (size_t i = 0; i < number_of_cores; i++) {
        threads[i].join();
    }

    return 0;
}
