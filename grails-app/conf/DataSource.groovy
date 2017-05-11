dataSource {
    pooled = true
    driverClassName = "org.postgresql.Driver"
    username = "postgres"
    password = "postgres"
    configClass = HibernateFilterDomainConfiguration
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory'
}

// environment specific settings
environments {
    development {
        def devUrl = System.env['FASE_DATABASE_DEVELOPMENT_URL']
        if (!devUrl)
            devUrl = "jdbc:postgresql://localhost/gerencia_fase_development";
        dataSource {
            //logSql = true
            password = "postgres"
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = devUrl
        }
        //hibernate { format_sql = true }
    }
    homologation {
        def devUrl = System.env['FASE_DATABASE_DEVELOPMENT_URL']
        if (!devUrl) devUrl =  devUrl = "jdbc:postgresql://localhost/gerencia_fase_homologation";

        dataSource {
            password = "postgres"
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = devUrl
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            devUrl = "jdbc:postgresql://localhost/gerencia_fase_homologation_test";
            password = "postgres"
            dbCreate = "update"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://localhost:5432/gerencia_fase_production";
            password = "postgres"
            dbCreate = "update"
            properties {
                // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                jdbcInterceptors = "ConnectionState"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
}
