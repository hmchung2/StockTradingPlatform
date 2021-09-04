package gc.co.kr.model.email;

 
public interface EmailService {
    
	//public void sendMail(EmailDTO dto);
    
    public void sendMail(String to, String subject, String body);
}

