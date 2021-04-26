module client.client;

import vibe.d;
import std.stdio;
import lib.irest;
import std.conv;

void main()
{

    auto api = new RestInterfaceClient!IRest("http://127.0.0.1:8080/");
    auto employees = api.getEmployees(); // Mengambil semua data employee (karyawan)
    writeln(employees); 

    writeln("Cari id karyawan: ");
    // auto number = readln;
    // int id = toInt(number);
    string text;
    text = readln.chomp;
    int number = to!int(text);
    auto employee = api.findEmployee(number); // Mencari employee dengan id = 1
    writeln(employee);

    writeln("Tambahkan nama depan karyawan: ");
    auto fName = readln;
    api.addEmployee(fName, IRest.Positions.Manager); // Untuk menambahkan employee dengan nama Firas dan posisi Manager
    employees = api.getEmployees();
    writeln(employees);

    api.putEmployee(IRest.Employee("Firas", 3, IRest.Positions.Janitor)); // Mengubah data Firas dengan posisi Janitor
    employees = api.getEmployees();
    writeln(employees);

    api.deleteEmployee(2); // Menghapus data dengan id = 2
    employees = api.getEmployees();
    writeln(employees);
}
