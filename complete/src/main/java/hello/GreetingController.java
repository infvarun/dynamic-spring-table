package hello;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
public class GreetingController {
    TreeMap<Integer, Table> allRows = new TreeMap<>();

    GreetingController(){
        allRows.put(100, new Table(100, "Varun", "Ved", "29"));
        allRows.put(101, new Table(101, "Vikky", "V", "18"));
        allRows.put(102, new Table(102, "John", "Doe", "38"));
        allRows.put(103, new Table(103, "Kim", "Hopper", "48"));
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @RequestMapping("/add")
    public List<Table> save(@RequestParam(value="fname") String fname,
                         @RequestParam(value="lname") String lname,
                         @RequestParam(value="age") String age) {
        int maxid = allRows.lastKey();
        int currentId = ++maxid;
        Table row = new Table(currentId, fname, lname, age);
        allRows.put(currentId, row);
        List<Table> rows = new ArrayList<>(allRows.values());
        return rows;
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @RequestMapping("/edit")
    public List<Table> edit(@RequestParam(value="id") int id,
                      @RequestParam(value="fname") String fname,
                      @RequestParam(value="lname") String lname,
                      @RequestParam(value="age") String age) {
        Table row = allRows.get(id);
        row.setFname(fname);
        row.setLname(lname);
        row.setAge(age);
        allRows.put(id, row);
        List<Table> rows = new ArrayList<>(allRows.values());
        return rows;
    }

    @CrossOrigin(origins = "http://localhost:8080")
    @RequestMapping("/list")
    public List<Table> list() {
        List<Table> rows = new ArrayList<>(allRows.values());
        return rows;
    }
}
