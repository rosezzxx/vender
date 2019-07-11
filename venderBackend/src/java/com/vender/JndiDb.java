/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

import com.vender.factory.ObjectFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
//import org.apache.commons.dbutils.BasicRowProcessor;
//import org.apache.commons.dbutils.handlers.MapListHandler;

/**
 *
 * @author sam
 */
public abstract class JndiDb {

    /**
     * JDNI DataSource
     */
    private String jndiDataSource;

    ObjectFactory listResultFactory;
    
    /**
     * List Map 的結果集
     */
    protected ListResult result;
    
    /**
     * 執行 SQL 語法後發生的錯誤訊息
     */
    private String errorMessage;
    
    /**
     * JDBC Connection
     */
    
    private Connection conn;
    /**
     * JDBC Statement
     */
    
    private Statement smt;
    
    /**
     * JDBC ResultSet
     */
    private ResultSet rs;

    /**
     * 執行的 SQL 語法
     */
    private String sqlMessage;
    
    /**
     * 用來暫存 prepared statement sql 要填入的變數
     */

    private List<String> preparedValue;

    /**
     * 是否要重置 preparedValue
     */    
    private boolean keepParameters;

    public JndiDb() {
        this.rs = null;
        this.smt = null;
        this.conn = null;
        this.errorMessage = null;
        this.keepParameters = false;
        this.preparedValue = new ArrayList<>();
        this.listResultFactory = new ObjectFactory();
    }

    /**
     * 設定 JNDI Data Source 字串
     *
     * @param jndiDataSource
     */
    final public void setDataSource(String jndiDataSource) {
        if (jndiDataSource == null) {
            this.jndiDataSource = "java:comp/env/jdbc/unknow";
        } else {
            this.jndiDataSource = jndiDataSource;
        }
    }

    /**
     * 取得 JNDI Data Source 連線，可繼承後進行其他初始化
     *
     * @param jndiDataSource
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    public void setJndi(String jndiDataSource) throws NamingException, SQLException {
        if (jndiDataSource != null) {
            this.jndiDataSource = jndiDataSource;
        }

        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup(this.jndiDataSource);
        conn = ds.getConnection();
        smt = conn.createStatement();
    }

    /**
     * 取得 JDBC 連線
     *
     * @return 傳回 JDBC 連線
     */
    public Connection getConn() {
        return this.conn;
    }

    /**
     * 取得 Statement
     *
     * @return
     */
    public Statement getStatement() {
        return this.smt;
    }

    public ResultSet getResultset() {
        return this.rs;
    }

    /**
     * 關閉資料庫連線
     */
    public void close() {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                errorMessage = e.getMessage();
            }
            rs = null;
        }
        if (smt != null) {
            try {
                smt.close();
            } catch (SQLException e) {
                errorMessage = e.getMessage();
            }
            smt = null;
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                errorMessage = e.getMessage();
            }
            conn = null;
        }
    }

    /**
     * 將資料庫結果集轉成 List<Map<String, Object>> 型別
     *
     * @param rs JDBC 結果集
     * @return 傳回結果集
     * @throws SQLException
     */
    protected List<Map<String, Object>> convertResultSetToMap() throws SQLException {
        List<Map<String, Object>> resultList = new ArrayList<>();
        ResultSetMetaData rsMetaData = rs.getMetaData();
        int colCount = rsMetaData.getColumnCount();
        while (rs.next()) {
            Map<String, Object> columnMap = result.getMap();    // 取得 Map 物件，型別由 ListResult 決定
            for (int i = 1; i <= colCount; i++) {
                columnMap.put(rsMetaData.getColumnName(i), rs.getObject(rsMetaData.getColumnName(i)));
            }
            resultList.add(columnMap);
        }
        return resultList;
    }

    /**
     * 取得錯誤訊息
     *
     * @return 傳回發生的錯誤訊息
     */
    public String getErrorMessage() {
        return errorMessage;
    }

    /**
     * 取得執行的 SQL
     *
     * @return 傳回執行的 SQL
     */
    public String getSqlMessage() {
        return sqlMessage;
    }

    /**
     * 執行 SQL 語法，以 ListResult 物件傳回
     *
     * @param sql MySQL 的 SQL 語法
     * @return 傳回 ListResult 型別，若發生錯誤， ListResult 的方法 getSqlMessage() 會傳回 null
     * ，執行 getResult().get(0).get("count") 傳回 -1L
     */
    public ListResult execSql(String sql) {
        sqlMessage = sql;
        result = listResultFactory.getListResult();
        result.setSqlMessage(sql);
        errorMessage = null;
        try {
            setJndi(null);
            rs = smt.executeQuery(sql);
//            BasicRowProcessor convert = new BasicRowProcessor();
//            MapListHandler handler = new MapListHandler(convert);
//            result.setResult(handler.handle(rs));
            result.setResult(convertResultSetToMap());
        } catch (NamingException | SQLException ex) {
            result.setResult("count", -1L);
            errorMessage = ex.getMessage();
        } finally {
            close();
        }
        result.setErrorMessage(errorMessage);
        return result;
    }

    /**
     * 更新資料庫 SQL 語法，以 ListResult 物件傳回
     *
     * @param sql MySQL 的 SQL 語法
     * @return 傳回 ListResult 型別，用 (long) getResult().get(0).get("count")
     * 取得影響筆數，若發生例外傳回 -1L
     */
    public ListResult updateSql(String sql) {
        sqlMessage = sql;
        result = listResultFactory.getListResult();
        result.setSqlMessage(sql);
        errorMessage = null;
        try {
            setJndi(null);
            long count = smt.executeUpdate(sql);
            result.setResult("count", count);
        } catch (NamingException | SQLException ex) {
            result.setResult("count", -1L);
            errorMessage = ex.getMessage();
        } finally {
            close();
        }
        result.setErrorMessage(errorMessage);
        return result;
    }

    /**
     * 設定 Prepared Statement 要填入的參數
     * @param value
     * @return 傳回 ? 字元作為佔位符，可與 SQL 語法結合
     */
    public String psString(String value) {
        preparedValue.add(value);
        return "?";
    }
    
    /**
     * 清除 Prepared Statement 要解析的參數
     */
    public void clearParameters() {
        preparedValue.clear();
        keepParameters = true;
    }

    /**
     * 使用 Prepared Statement 執行 SQL 語法，以 ListResult 物件傳回
     *
     * @param sql MySQL 的 SQL 語法
     * @return 傳回 ListResult 型別，若發生錯誤， ListResult 的方法 getSqlMessage() 會傳回 null
     * ，執行 getResult().get(0).get("count") 傳回 -1L
     */
    public ListResult execPsSql(String sql) {
        sqlMessage = sql;
        result = listResultFactory.getListResult();
        result.setSqlMessage(sql);
        errorMessage = null;
        try {
            setJndi(null);
            PreparedStatement pSmt = conn.prepareStatement(sql);
            int i = 1;
            for (String value : preparedValue) {
                pSmt.setString(i++, value);
            }
            rs = pSmt.executeQuery();
            result.setResult(convertResultSetToMap());
            pSmt.clearParameters();
        } catch (NamingException | SQLException ex) {
            result.setResult("count", -1L);
            errorMessage = ex.getMessage();
        } finally {
            close();
            if (keepParameters == false) { // 使用 execPsSqlKeepParameters() 方法時，不清除參數
                preparedValue.clear();
            }
            keepParameters = false;
        }
        result.setErrorMessage(errorMessage);
        return result;
    }

    /**
     * 使用 Prepared Statement 執行 SQL 語法，以 ListResult 物件傳回，使用此方法
     * 不會清除由 psString() 方法所設定的參數
     * @param sql MySQL 的 SQL 語法
     * @return 傳回 ListResult 型別，若發生錯誤， ListResult 的方法 getSqlMessage() 會傳回 null
     * ，執行 getResult().get(0).get("count") 傳回 -1L
     */    
    public ListResult execPsSqlKeepParameters(String sql) {
        keepParameters = true;
        return execPsSql(sql);
    }

    /**
     * 以 Prepared Statement 更新資料庫，結果用 ListResult 物件傳回
     *
     * @param sql MySQL 的 SQL 語法
     * @return 傳回 ListResult 型別，用 (long) getResult().get(0).get("count")
     * 取得影響筆數，若發生錯誤傳回 -1L
     */
    public ListResult UpdatePsSql(String sql) {
        sqlMessage = sql;
        result = listResultFactory.getListResult();
        result.setSqlMessage(sql);
        errorMessage = null;
        try {
            setJndi(null);
            PreparedStatement pSmt = conn.prepareStatement(sql);
            int i = 1;
            for (String value : preparedValue) {
                pSmt.setString(i++, value);
            }
            long count = pSmt.executeUpdate();
            result.setResult("count", count);
            pSmt.clearParameters();
        } catch (NamingException | SQLException ex) {
            result.setResult("count", -1L);
            errorMessage = ex.getMessage();
        } finally {
            close();
            preparedValue.clear();
        }
        result.setErrorMessage(errorMessage);
        return result;
    }
}
