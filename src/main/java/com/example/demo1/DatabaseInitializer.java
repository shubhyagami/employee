package com.example.demo1;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DatabaseUtil.initializeDatabase();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
