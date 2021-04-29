module server.server;
import std.stdio;

import vibe.d;

import lib.irest;

class Rest : IRest
{
    private Employee[] employee_;

    this()
    {
        employee_ = [
            Employee("Adib", 1, Positions.Manager),
            Employee("Firas", 2, Positions.Manager)
        ];
    }

@safe:
override:
    Employee[] getEmployees()
    {
        return employee_;
    }

    Employee findEmployee(int id)
    {

        foreach (e; employee_)
        {
            if (e.id == id)
            {
                return e;
            }
        }
        writeln("Employee not found.");
        assert(0);
    }

    int addEmployee(string name, Positions position)
    {
        import std.algorithm : map, max, reduce;

        // Generate the next highest ID
        auto newId = employee_.map!(x => x.id)
            .reduce!max + 1;
        employee_ ~= Employee(name, newId, position);
        return newId;
    }

    int putEmployee(Employee employee)
    {
        foreach (ref e; employee_)
        {
            if (e.id == employee.id)
            {
                e = employee;
                return e.id;
            }
        }
        writeln("Employee not found.");
        assert(0);
    }

    bool deleteEmployee(int id)
    {
        foreach (i, ref e; employee_)
        {
            if (e.id == id)
            {
                import std.algorithm.mutation : remove;

                employee_ = employee_.remove(i);
                return true;
            }
        }

        writeln("Employee not found.");
        assert(0);
    }
}

shared static this()
{
    auto router = new URLRouter;
    router.registerRestInterface(new Rest);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["::1", "127.0.0.1"];
    listenHTTP(settings, router);
}
