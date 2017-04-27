package com.berlizz.security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentRememberMeToken;

public class CustomJdbcTokenRepositoryImpl extends JdbcTokenRepositoryImpl {
	
	private String tokensBySeriesSql = "";
	private String insertTokenSql = "";
	private String updateTokenSql = "";
	private String removeUserTokensSql = "";

	@Override
	public void createNewToken(PersistentRememberMeToken token) {
		getJdbcTemplate().update(insertTokenSql, token.getUsername(), token.getSeries(),
				token.getTokenValue(), token.getDate());
	}
	
	@Override
	public void updateToken(String series, String tokenValue, Date lastUsed) {
		getJdbcTemplate().update(updateTokenSql, tokenValue, lastUsed, series);
	}
	
	@Override
	public PersistentRememberMeToken getTokenForSeries(String seriesId) {
		try {
			return getJdbcTemplate().queryForObject(tokensBySeriesSql,
					new RowMapper<PersistentRememberMeToken>() {
						public PersistentRememberMeToken mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							return new PersistentRememberMeToken(rs.getString(1), rs
									.getString(2), rs.getString(3), rs.getTimestamp(4));
						}
					}, seriesId);
		}
		catch (EmptyResultDataAccessException zeroResults) {
			if (logger.isDebugEnabled()) {
				logger.debug("Querying token for series '" + seriesId
						+ "' returned no results.", zeroResults);
			}
		}
		catch (IncorrectResultSizeDataAccessException moreThanOne) {
			logger.error("Querying token for series '" + seriesId
					+ "' returned more than one value. Series" + " should be unique");
		}
		catch (DataAccessException e) {
			logger.error("Failed to load token for series " + seriesId, e);
		}

		return null;
	}
	
	@Override
	public void removeUserTokens(String username) {
		getJdbcTemplate().update(removeUserTokensSql, username);
	}

	public String getTokensBySeriesSql() {
		return tokensBySeriesSql;
	}

	public void setTokensBySeriesSql(String tokensBySeriesSql) {
		this.tokensBySeriesSql = tokensBySeriesSql;
	}

	public String getInsertTokenSql() {
		return insertTokenSql;
	}

	public void setInsertTokenSql(String insertTokenSql) {
		this.insertTokenSql = insertTokenSql;
	}

	public String getUpdateTokenSql() {
		return updateTokenSql;
	}

	public void setUpdateTokenSql(String updateTokenSql) {
		this.updateTokenSql = updateTokenSql;
	}

	public String getRemoveUserTokensSql() {
		return removeUserTokensSql;
	}

	public void setRemoveUserTokensSql(String removeUserTokensSql) {
		this.removeUserTokensSql = removeUserTokensSql;
	}
	
	
}
