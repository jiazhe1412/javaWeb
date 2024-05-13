package Persistence;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DatabaseUtil {
    private static final String DEFAULT_PERSISTENCE_UNIT_NAME = "GUI_ASSIGNMENTPU";
    private static EntityManagerFactory entityManagerFactory;

    private DatabaseUtil() {
        // Private constructor to prevent instantiation
    }

    public static synchronized EntityManagerFactory getEntityManagerFactory() {
        if (entityManagerFactory == null) {
            entityManagerFactory = Persistence.createEntityManagerFactory(DEFAULT_PERSISTENCE_UNIT_NAME);
        }
        return entityManagerFactory;
    }

    public static synchronized EntityManagerFactory getEntityManagerFactory(String persistenceUnitName) {
        if (entityManagerFactory == null || !entityManagerFactory.isOpen()) {
            entityManagerFactory = Persistence.createEntityManagerFactory(persistenceUnitName);
        }
        return entityManagerFactory;
    }

    public static synchronized void closeEntityManagerFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
            entityManagerFactory = null; // Reset the reference to allow re-initialization
        }
    }
}