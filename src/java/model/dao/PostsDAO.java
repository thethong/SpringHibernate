/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package model.dao;
import java.util.List;
import model.pojo.Posts;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
/**
 *
 * @author user
 */
public class PostsDAO {
    public static List<Posts> getList()
    {
        List<Posts> lst = null;
        
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Posts";
            Query query = session.createQuery(hql);
            lst = query.list();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return lst;
    }
}
