module lib.irest;

import vibe.d;
interface IRest
{
    struct Employee
    {
        string name;
        int id;
        Positions position;
    }

    enum Positions {
        Cashier,
        Clerk,
        Manager,
        Janitor
    }
    @safe:
    @method(HTTPMethod.GET)
    @path("/api/v1/get-employees")
    Employee[] getEmployees();

    @method(HTTPMethod.GET)
    @path("/api/v1/find-employee")
    Employee findEmployee(int id);

    @path("/api/v1/add-employee")
    @method(HTTPMethod.POST)
    int addEmployee(string name, Positions position);

    @path("/api/v1/put-employee")
    @method(HTTPMethod.PUT)
    int putEmployee(Employee employee);

    @path("/api/v1/del-employee")
    @method(HTTPMethod.DELETE)
    bool deleteEmployee(int id);
}