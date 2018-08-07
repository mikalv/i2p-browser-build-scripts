/*
 * Bug 25485: Browser/TorBrowser/Tor/libstdc++.so.6: version `CXXABI_1.3.11' not found
 * This program is borrowed from
 * https://en.cppreference.com/w/cpp/error/uncaught_exception and is useful in
 * determining the latest C++ ABI. Specifically this program requires
 * `GLIBCXX_3.4.22` which we use to compare the version of the installed
 * libstdc++.so.6 and the bundled version. If the program executes
 * successfully, that means we should use the system version of libstdc++.so.6
 * and if not, that means we should use the bundled version.
 */

#include <iostream>
#include <exception>
#include <stdexcept>

struct Foo {
    int count = std::uncaught_exceptions();
    ~Foo() {
        std::cout << (count == std::uncaught_exceptions()
            ? "~Foo() called normally\n"
            : "~Foo() called during stack unwinding\n");
    }
};

int main()
{
    Foo f;
    try {
        Foo f;
        std::cout << "Exception thrown\n";
        throw std::runtime_error("test exception");
    } catch (const std::exception& e) {
        std::cout << "Exception caught: " << e.what() << '\n';
    }
}
