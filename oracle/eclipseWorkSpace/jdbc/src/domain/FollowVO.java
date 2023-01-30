package domain;

public class FollowVO {
	private Long followId;
	private Long followingId;
	private Long followedId;
	
	public FollowVO() {;}

	public Long getFollowId() {
		return followId;
	}

	public void setFollowId(Long followId) {
		this.followId = followId;
	}

	public Long getFollowingId() {
		return followingId;
	}

	public void setFollowingId(Long followingId) {
		this.followingId = followingId;
	}

	public Long getFollowedId() {
		return followedId;
	}

	public void setFollowedId(Long followedId) {
		this.followedId = followedId;
	}
	
}
