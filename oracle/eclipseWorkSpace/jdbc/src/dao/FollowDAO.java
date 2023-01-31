package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.FollowVO;
import domain.ReplyDTO;
import domain.UserVO;

public class FollowDAO {
	public Connection connection;
	public PreparedStatement preparedStatement;
	public ResultSet resultSet;

	//	팔로우 주체와 팔로우 대상을 매개변수로 하여 팔로우(create)
	public void follow(Long followingId, Long followedId) {
		String query = "INSERT INTO TBL_FOLLOW " 
				+ "(FOLLOW_ID, FOLLOWING_ID, FOLLOWED_ID, FOLLOW_DATE) "
				+ "VALUES(SEQ_FOLLOW.NEXTVAL, ?, ?, SYSDATE)";

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, followingId);
			preparedStatement.setLong(2, followedId);

			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}

	}

	//	팔로우 주체와 팔로우 대상의 아이디를 매개변수로 하여 언팔로우(delete)
	public void unfollow(Long followingId, Long followedId) {
		String query = "DELETE FROM TBL_FOLLOW " + "WHERE FOLLOWING_ID = ? AND FOLLOWED_ID = ?";

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, followingId);
			preparedStatement.setLong(2, followedId);

			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}

	}
	
	//	세션 아이디 사용 - 언팔로우(delete)
	public void unfollow(Long followedId) {
		String query = "DELETE FROM TBL_FOLLOW " 
				+ "WHERE FOLLOWING_ID = ? AND FOLLOWED_ID = ?";

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, UserDAO.userId);
			preparedStatement.setLong(2, followedId);

			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}

	}

	// [매개변수]를 팔로우한 사람들의 정보
	public ArrayList<UserVO> selectAllByFollowed(Long followedId) {
		String query = "SELECT USER_ID, USER_IDENTIFICATION, USER_NAME, " + "USER_PASSWORD, USER_PHONE, USER_NICKNAME, "
				+ "USER_EMAIL, USER_ADDRESS, USER_BIRTH, " + "USER_GENDER, USER_RECOMMENDER_ID " + "FROM TBL_USER "
				+ "WHERE USER_ID IN (SELECT FOLLOWING_ID FROM TBL_FOLLOW " + "WHERE FOLLOWED_ID = ?)";
		UserVO userVO = null;
		ArrayList<UserVO> results = new ArrayList<UserVO>();

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, followedId);
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				userVO = new UserVO();
				userVO.setUserId(resultSet.getLong(1));
				userVO.setUserIdentification(resultSet.getString(2));
				userVO.setUserName(resultSet.getString(3));
				userVO.setUserPassword(resultSet.getString(4));
				userVO.setUserPhone(resultSet.getString(5));
				userVO.setUserNickname(resultSet.getString(6));
				userVO.setUserEmail(resultSet.getString(7));
				userVO.setUserAddress(resultSet.getString(8));
				userVO.setUserBirth(resultSet.getString(9));
				userVO.setUserGender(resultSet.getString(10));
				userVO.setUserRecommenderId(resultSet.getString(11));
				results.add(userVO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return results;
	}
	
	//	세션의 유저아이디를 팔로우한 사람들의 정보 조회(selectAll)
	public ArrayList<UserVO> selectAllByFollowed(/* Long followedId */) {
		String query = "SELECT USER_ID, USER_IDENTIFICATION, USER_NAME, " + "USER_PASSWORD, USER_PHONE, USER_NICKNAME, "
				+ "USER_EMAIL, USER_ADDRESS, USER_BIRTH, " + "USER_GENDER, USER_RECOMMENDER_ID " + "FROM TBL_USER "
				+ "WHERE USER_ID IN (SELECT FOLLOWING_ID FROM TBL_FOLLOW " + "WHERE FOLLOWED_ID = ?)";
		UserVO userVO = null;
		ArrayList<UserVO> results = new ArrayList<UserVO>();

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, UserDAO.userId);
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				userVO = new UserVO();
				userVO.setUserId(resultSet.getLong(1));
				userVO.setUserIdentification(resultSet.getString(2));
				userVO.setUserName(resultSet.getString(3));
				userVO.setUserPassword(resultSet.getString(4));
				userVO.setUserPhone(resultSet.getString(5));
				userVO.setUserNickname(resultSet.getString(6));
				userVO.setUserEmail(resultSet.getString(7));
				userVO.setUserAddress(resultSet.getString(8));
				userVO.setUserBirth(resultSet.getString(9));
				userVO.setUserGender(resultSet.getString(10));
				userVO.setUserRecommenderId(resultSet.getString(11));
				results.add(userVO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return results;
	}

	// [매개변수]가 팔로우한 사람들의 정보
	public ArrayList<UserVO> selectAllByFollowing(Long followingId) {
		String query = "SELECT USER_ID, USER_IDENTIFICATION, USER_NAME, " + "USER_PASSWORD, USER_PHONE, USER_NICKNAME, "
				+ "USER_EMAIL, USER_ADDRESS, USER_BIRTH, " + "USER_GENDER, USER_RECOMMENDER_ID " + "FROM TBL_USER "
				+ "WHERE USER_ID IN (SELECT FOLLOWED_ID FROM TBL_FOLLOW " + "WHERE FOLLOWING_ID = ?)";
		UserVO userVO = null;
		ArrayList<UserVO> results = new ArrayList<UserVO>();

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, followingId);
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				userVO = new UserVO();
				userVO.setUserId(resultSet.getLong(1));
				userVO.setUserIdentification(resultSet.getString(2));
				userVO.setUserName(resultSet.getString(3));
				userVO.setUserPassword(resultSet.getString(4));
				userVO.setUserPhone(resultSet.getString(5));
				userVO.setUserNickname(resultSet.getString(6));
				userVO.setUserEmail(resultSet.getString(7));
				userVO.setUserAddress(resultSet.getString(8));
				userVO.setUserBirth(resultSet.getString(9));
				userVO.setUserGender(resultSet.getString(10));
				userVO.setUserRecommenderId(resultSet.getString(11));
				results.add(userVO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return results;
	}
	//	팔로우의 주체인 세션 아이디가 팔로우한 대상들의 목록 조회
	public ArrayList<UserVO> selectAllByFollowing(/* Long followingId */) {
		String query = "SELECT USER_ID, USER_IDENTIFICATION, USER_NAME, " + "USER_PASSWORD, USER_PHONE, USER_NICKNAME, "
				+ "USER_EMAIL, USER_ADDRESS, USER_BIRTH, " + "USER_GENDER, USER_RECOMMENDER_ID " + "FROM TBL_USER "
				+ "WHERE USER_ID IN (SELECT FOLLOWED_ID FROM TBL_FOLLOW " + "WHERE FOLLOWING_ID = ?)";
		UserVO userVO = null;
		ArrayList<UserVO> results = new ArrayList<UserVO>();

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, UserDAO.userId);
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				userVO = new UserVO();
				userVO.setUserId(resultSet.getLong(1));
				userVO.setUserIdentification(resultSet.getString(2));
				userVO.setUserName(resultSet.getString(3));
				userVO.setUserPassword(resultSet.getString(4));
				userVO.setUserPhone(resultSet.getString(5));
				userVO.setUserNickname(resultSet.getString(6));
				userVO.setUserEmail(resultSet.getString(7));
				userVO.setUserAddress(resultSet.getString(8));
				userVO.setUserBirth(resultSet.getString(9));
				userVO.setUserGender(resultSet.getString(10));
				userVO.setUserRecommenderId(resultSet.getString(11));
				results.add(userVO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return results;
	}
	
	//	userId의 팔로우 카운트
	public Long countFollowing(Long userId) {
		String query = "SELECT COUNT_FI FROM VIEW_FOLLOW " + "WHERE FID = ?";
		Long result = 0L;

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, userId);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				result = resultSet.getLong(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return result;
	}
	
	//	세션 아이디의 팔로우 카운트
	public Long countFollowing(/* Long userId */) {
		String query = "SELECT COUNT_FI FROM VIEW_FOLLOW " + "WHERE FID = ?";
		Long result = 0L;

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, UserDAO.userId);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				result = resultSet.getLong(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return result;
	}
	
	//	userId를 팔로우한 사람들 수 카운트
	public Long countFollowed(Long userId) {
		String query = "SELECT COUNT_FD FROM VIEW_FOLLOW " + "WHERE FID = ?";
		Long result = 0L;

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, userId);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				result = resultSet.getLong(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return result;
	}
	
	//	userId를 팔로우한 사람들 수 카운트
	public Long countFollowed(/* Long userId */) {
		String query = "SELECT COUNT_FD FROM VIEW_FOLLOW " + "WHERE FID = ?";
		Long result = 0L;

		connection = DBConnecter.getConnection();
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setLong(1, UserDAO.userId);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				result = resultSet.getLong(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		return result;
	}
}
