package gdu.mall.vo;

public class Category {
	private int categoryNo;
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getCategoryWeight() {
		return categoryWeight;
	}
	public void setCategoryWeight(int categoryWeight) {
		this.categoryWeight = categoryWeight;
	}
	public String getCategoryDate() {
		return categoryDate;
	}
	public void setCategoryDate(String categoryDate) {
		this.categoryDate = categoryDate;
	}
	private String categoryName;
	private int categoryWeight;
	private String categoryDate;
	
	
}