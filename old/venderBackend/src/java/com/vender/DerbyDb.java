/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vender;

import org.owasp.esapi.ESAPI;
import org.owasp.esapi.codecs.Codec;
import org.owasp.esapi.codecs.OracleCodec;

/**
 *
 * @author sam
 */
public abstract class DerbyDb extends DbConnector {

    @Override
    public String escapeString(String noneEscapeString) {
        Codec oracleCodec = new  OracleCodec();
        return ESAPI.encoder().encodeForSQL(oracleCodec, noneEscapeString);
    }

    @Override
    public DerbyPagination getPagination() {
        return new DerbyPagination(0, 1, 10);
    }

    @Override
    public DerbyPagination getPagination(long total, long page, long limit) {
        return new DerbyPagination(total, page, limit);
    }
    
}
