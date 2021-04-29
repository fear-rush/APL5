module client.client;

import vibe.d;
import std.stdio;
import lib.irest;
import std.conv;

void main()
{
    writeln("APLIKASI SEDERHANA PENGGUNAAN REST API");
    writeln("Adib Siddhi Adhipta (19/444034/TK/49230)\nMuhammad Firas Zahid Suryaatmaja (19/439816/TK/48546) ");
    
    
    bool flag = true;


    while(flag == true) {

        writeln("MENU");
        writeln("1. Menambah Karyawan\n2. Edit Karyawan\n3. Mencari Karyawan\n4. Menghapus Karyawan");
        string choice;
        choice = readln.chomp;
        int select = to!int(choice);

        auto api = new RestInterfaceClient!IRest("http://127.0.0.1:8080/");
        auto employees = api.getEmployees(); // Mengambil semua data employee (karyawan)
        writeln(employees); 

        if(select == 1) {
            writeln("Tambahkan nama depan karyawan: ");
            auto fName = readln.chomp;;
            writeln("Tambahkan posisi karyawan:");
            writeln("1. Manager\n2. Cashier\n3. Clerk\n4. Janitor\n");
            string txt;
            txt = readln.chomp;
            int pos = to!int(txt);
            IRest.Positions position;

            switch (pos) {
                case 1:
                position = IRest.Positions.Manager;
                case 2:
                position = IRest.Positions.Cashier;
                case 3:
                position = IRest.Positions.Clerk;
                case 4:
                position = IRest.Positions.Janitor;
                default:
                writeln("Posisi yang diinput tidak tersedia");
            }
            api.addEmployee(fName, position); // Untuk menambahkan employee dengan nama Firas dan posisi Manager
            employees = api.getEmployees();
            writeln(employees);
        }

        else if(select == 2){
            writeln("Masukkan id karyawan yang ingin diedit: ");
            string edit;
            edit = readln.chomp;
            int editID = to!int(edit);
            IRest.Employee editEmployee= api.findEmployee(editID);
            writeln(editEmployee);
            writeln("Masukkan penggantian nama: ");
            string editName;
            editName = readln.chomp;

            writeln("\nMasukkan penggantian posisi: ");
            writeln("1. Manager\n2. Cashier\n3. Clerk\n4. Janitor\n");
            string editTxt;
            editTxt = readln.chomp;
            int editPos = to!int(editTxt);
            IRest.Positions editPosition;

            switch (editPos) {
                case 1:
                editPosition = IRest.Positions.Manager;
                case 2:
                editPosition = IRest.Positions.Cashier;
                case 3:
                editPosition = IRest.Positions.Clerk;
                case 4:
                editPosition = IRest.Positions.Janitor;
                default:
                writeln("Posisi yang diinput tidak tersedia");
            }

            api.putEmployee(IRest.Employee(editName, editEmployee.id, editPosition)); // Mengubah data Firas dengan posisi Janitor
            employees = api.getEmployees();
            writeln(employees);
        }

        else if(select == 3){
            writeln("Cari id karyawan: ");
            string text;
            text = readln.chomp;
            int number = to!int(text);
            auto employee = api.findEmployee(number); // Mencari employee dengan id = 1
            writeln(employee);
        }

        else if(select == 4){
            writeln("Masukkan id karyawan yang ingin dihapus: ");
            string delID;
            delID = readln.chomp;
            int deleteID = to!int(delID);
            api.deleteEmployee(deleteID); // Menghapus data dengan id = 2
            employees = api.getEmployees();
            writeln(employees);
        }

        else {
            writeln("Pilihan tidak tersedia");
        }

        writeln("Apakah anda ingin menggunakan aplikasi ini lagi (Y/N)");
        char exit;
        exit = to!char(toUpper(readln.chomp));
        if(exit == 'Y'){
            flag = true;
        } else if(exit == 'N') {
            flag = false;
            writeln("Terimakasih");
        }

            
        }

    
}
