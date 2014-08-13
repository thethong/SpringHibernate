package controller;

import java.util.*;
import model.dao.PostsDAO;
import model.pojo.Posts;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/animal")
public class AnimalController {

    @RequestMapping(value = "/list_animal")
    public String seach(ModelMap mm) {
        List<Posts> lst = PostsDAO.getList();
        mm.put("lst", lst);
        return "list_animals";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public @ResponseBody
    String getTime() {

        Random rand = new Random();
        float r = rand.nextFloat() * 100;
        String result = "<br>Next Random # is <b>" + r + "</b>. Generated on <b>" + new Date().toString() + "</b>";
        System.out.println("Debug Message from CrunchifySpringAjaxJQuery Controller.." + new Date().toString());
        return "12345";
    }
    @RequestMapping(value = "/get", method = RequestMethod.GET)
    public @ResponseBody
    String aaaa() {
        return "12345";
    }
    
    @RequestMapping(value = "/post.html", method = RequestMethod.POST)
    public @ResponseBody
    String bbb() {
        return "6666666";
    }

//    @Controller
//    @RequestMapping("/search")
//    public class EmployeeController {
//        @RequestMapping(method = RequestMethod.POST)
//        public @ResponseBody
//        String add(HttpServletRequest request, HttpServletResponse response)
//                throws Exception {
//
//            
//
//            return "123456";
//        }
//    }
}
