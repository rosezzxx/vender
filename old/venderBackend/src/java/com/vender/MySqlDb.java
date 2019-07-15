/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.NamingException;
import org.owasp.esapi.ESAPI;
import org.owasp.esapi.codecs.Codec;
import org.owasp.esapi.codecs.MySQLCodec;

/**
 *
 * @author sam
 */
public abstract class MySqlDb extends DbConnector {
    /**
     * 取得 JNDI Data Source 連線後，設定語系
     * @param jndiDataSource
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    @Override
    public void setJndi(String jndiDataSource) throws NamingException, SQLException {
        super.setJndi(jndiDataSource);
        Statement mysqlStm = getStatement();
        mysqlStm.executeQuery("SET NAMES utf8mb4");    // 設定語系
    }

    /**
     * 轉換特殊字元，避免 String 類型的  SQL Injection
     * @param noneEscapeString  需要轉換的字串
     * @return 傳回轉換後的字串
     */
    @Override
    public String escapeString(String noneEscapeString) {
        Codec mysqlCodec = new MySQLCodec(MySQLCodec.MYSQL_MODE);
        return ESAPI.encoder().encodeForSQL(mysqlCodec, noneEscapeString);
    }
    
    @Override
    public MySqlPagination getPagination() {
        return new MySqlPagination(0, 1, 10);
    }
    
    @Override
    public MySqlPagination getPagination(long total, long page, long limit) {
        return new MySqlPagination(total, page, limit);
    }
}
