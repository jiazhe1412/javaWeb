/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;
import javax.transaction.Status;
import javax.transaction.UserTransaction;

public class CategoryService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;
    @Resource
    UserTransaction utx;

    public CategoryService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addCategory(Category category) {
        mgr.persist(category);
        return true;
    }

    public Category findCategoryById(String id) {
        try {
            Category category = mgr.find(Category.class, id);
            return category;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error finding category by ID: " + e.getMessage()); // Print the error message
            return null;
        }
    }

    public boolean deleteCategory(String id) {
        Category category = findCategoryById(id);
        if (category != null) {
            try (Connection connection = getConnection()) {
                boolean hasProducts = hasAssociatedProducts(connection, id); // Pass 'id' instead of 'categoryId'

                if (hasProducts) {
                    return false;
                } else {
                    String sql = "DELETE FROM CATEGORY WHERE CATEGORYID = ?";
                    try (PreparedStatement statement = connection.prepareStatement(sql)) {
                        statement.setString(1, id);
                        statement.executeUpdate();
                    }
                    return true;
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Handle or log the exception
                return false;
            }
        }
        return false;
    }

    public Connection getConnection() throws SQLException {
        String url = "jdbc:derby://localhost:1527/gui";
        String username = "users";
        String password = "12345";
        return DriverManager.getConnection(url, username, password);
    }

    private boolean hasAssociatedProducts(Connection connection, String categoryId) {
        String sql = "SELECT COUNT(*) FROM PRODUCT WHERE CATEGORYID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception
        }
        return false;
    }

    public List<Category> findAll() {
        List categoryList = mgr.createNamedQuery("Category.findAll").getResultList();
        return categoryList;
    }

    public boolean updatecategory(Category category) {
        try {
            Category tempCategory = findCategoryById(category.getCategoryid());
            if (tempCategory != null) {
                tempCategory.setCategorytype(category.getCategorytype());
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Integer getMaxCategoryId() {
        Query query = mgr.createQuery("SELECT MAX(c.categoryid) FROM Category c");
        String maxCategoryIdStr = (String) query.getSingleResult();
        if (maxCategoryIdStr == null || maxCategoryIdStr.isEmpty()) {
            return 1001;
        } else {
            return Integer.parseInt(maxCategoryIdStr) + 1;
        }
    }
}