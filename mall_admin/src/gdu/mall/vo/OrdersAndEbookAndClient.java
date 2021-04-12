package gdu.mall.vo;

public class OrdersAndEbookAndClient {
	private Orders orders;
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public Ebook getEbook() {
		return ebook;
	}
	public void setEbook(Ebook ebook) {
		this.ebook = ebook;
	}
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	private Ebook ebook;
	private Client client;
}
