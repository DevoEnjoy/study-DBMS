package view;

import java.util.Scanner;

import dao.BoardDAO;
import dao.UserDAO;
import domain.BoardVO;
import domain.UserVO;

public class Console {

	public static String arToMsg(String[] arStr) {
		String result = "";
		for (int i = 0; i < arStr.length; i++) {
			result += i + ". " + arStr[i] + "\n";
		}
		return result;
	}

	public static int nextLineToInt(String nextLine) {
		int result = 0;

		try {
			result = Integer.parseInt(nextLine);
		} catch (NumberFormatException e) {
			return -1;
		}
		return result;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		UserVO userVO = null;
		UserDAO userDAO = new UserDAO();
		BoardVO boardVO = null;
		BoardDAO boardDAO = new BoardDAO();
		String[] arBeforeMenu = { "홈", "로그인", "회원가입", "창 닫기" }, arAfterMenu = { "홈", "로그아웃", "게시판", "창닫기" },
				boardMenu = { "홈", "게시글 목록 보기", "글쓰기" };
		String beforeMenuMsg = arToMsg(arBeforeMenu), afterMenuMsg = arToMsg(arAfterMenu),
				boardMenuMsg = arToMsg(boardMenu);
		String inputErrMsg = "잘못된 입력입니다.", backToMenuMsg = "메인메뉴로 돌아갑니다.", backToLoginMsg = "로그인 페이지로 돌아갑니다.",
				backToJoinMsg = "회원가입 페이지로 돌아갑니다.", doneJoinMsg = "회원가입이 완료되었습니다.", welcomeLogin = "현재 로그인 상태입니다.";
		String inputIdMsg = "아이디: ", inputPwMsg = "비밀번호: ", failLoginMsg = "아이디 혹은 비밀번호가 잘못되었습니다.";
		String joinMenuMsg = "회원가입 페이지입니다. 필요한 정보를 입력하세요.", checkIdFalseMsg = "이미 존재하는 아이디입니다. 다시 입력해 주세요.";
		String temp = null, temp2 = null;
		String inputNameMsg = "이름 : ", inputPhoneMsg = "핸드폰 번호 : ", inputEmailMsg = "이메일 : ",
				inputChoiceMoreInfoMsg = "(선택)추가 정보를 입력하시겠습니까?";
		String inputNicknameMsg = "닉네임 입력(중복 가능) : ", inputAddressMsg = "주소 입력 : ",
				inputBirthMsg = "생년월일(yyyymmdd) 입력 : ";
		String additionalInputMsg = "추가정보 입력 페이지입니다.\n입력을 원하지 않으면 Enter를 눌러 입력을 건너뛰세요.";
		String insertErrMsg = "회원가입에 실패했습니다.\n메인메뉴로 돌아갑니다.", logoutMsg = "안전하게 로그아웃합니다.";
		boolean didLogin = false;
		int choice = 0;

//		IntStream.range(0, arBeforeMenu.length).map(i -> i + ". " + arBeforeMenu[i] + "\n").forEach(System.out::println);
//		for (int i = 0; i < arBeforeMenu.length; i++) {
//			beforeMenuMsg += i + ". " + arBeforeMenu[i] + "\n";
//		}

		while (true) {

			// 메뉴
			System.out.println("\n\n");
			System.out.println(didLogin ? afterMenuMsg : beforeMenuMsg);
			choice = nextLineToInt(sc.nextLine());

			if (choice == -1) {
				System.err.printf("%s\n%s\n", inputErrMsg, backToMenuMsg);
				continue;
			} else if (choice == 0) {
				System.out.println("\n\n\n\n");
				continue;
			}
			if (didLogin) {
				System.out.println(welcomeLogin + "\nID : daniel93");
			}
			// 로그인 전
			if (!didLogin) {
				// // 로그인 서비스
				userVO = new UserVO();
				if (choice == 1) {
					while (!didLogin) {
						System.out.print(inputIdMsg);
						userVO.setUserIdentification(sc.nextLine());

						System.out.print(inputPwMsg);
						userVO.setUserPassword(sc.nextLine());

						// 로그인 성공시
						if (userDAO.login(userVO.getUserIdentification(), userVO.getUserPassword())) {
							userVO = userDAO.select(userVO.getUserIdentification());
							didLogin = true;
							break;
						} else { // 로그인 실패시
							System.err.printf("%s\n%s\n", failLoginMsg, backToLoginMsg);
							break;
						}
					}
					// // 회원가입 서비스
				} else if (choice == 2) {

					System.out.println(joinMenuMsg);
					while (true) {
						System.out.print(inputIdMsg);
						temp = sc.nextLine();
						if (userDAO.checkId(temp)) {
							userVO.setUserIdentification(temp);
							break;
						} else {
							System.out.println(checkIdFalseMsg);
							continue;
						}

					}

					while (true) {
						temp = null;
						temp2 = null;
						System.out.print(inputPwMsg);
						temp = sc.nextLine();

						System.out.print("(재입력) " + inputPwMsg);
						temp2 = sc.nextLine();
						if (temp.equals(temp2)) {
							userVO.setUserPassword(temp);
							break;
						} else {
							System.out.println(inputErrMsg);
							System.out.println(backToJoinMsg);
							continue;
						}
					}
					System.out.print(inputNameMsg);
					userVO.setUserName(sc.nextLine());

					System.out.print(inputPhoneMsg);
					userVO.setUserPhone(sc.nextLine());

					System.out.print(inputEmailMsg);
					userVO.setUserEmail(sc.nextLine());
					while (true) {
						System.out.print(inputChoiceMoreInfoMsg);
						System.out.println("\n1. 추가정보 입력\n2. 회원가입 진행");
						try {
							choice = Integer.parseInt(sc.nextLine());
						} catch (NumberFormatException e) {
							System.err.println(inputErrMsg);
							System.out.println(backToMenuMsg);
							continue;
						}
						if (choice == 2) {
							userDAO.insert(userVO);
							System.out.println(backToMenuMsg);
							break;
						}
						System.out.println(additionalInputMsg);
						System.out.print(inputNicknameMsg);
						userVO.setUserNickname(sc.nextLine());

						System.out.print(inputAddressMsg);
						userVO.setUserAddress(sc.nextLine());

						System.out.println(inputBirthMsg);
						userVO.setUserBirth(sc.nextLine());

						// 회원가입 성공
						try {
							userDAO.insert(userVO);
						} catch (Exception e) {
							e.printStackTrace();
							System.err.println(insertErrMsg);
							continue;
						}
						System.out.println(doneJoinMsg);
						break;
					}
					continue;
				}

				// // 로그인 후
			} else if (didLogin) {
				while (true) {

//					choice = Integer.parseInt(sc.nextLine());
					if (choice == 0) {
						System.out.println(backToMenuMsg);
						break;
					}
					// // 로그아웃 서비스
					if (choice == 1) {
						System.out.println(logoutMsg);
						didLogin = false;
						break;
						// // 게시판 서비스
					} else if (choice == 2) {
						while (true) {
							System.out.println("게시판");
							System.out.println("=================================");
							System.out.println(boardMenuMsg);
							System.out.println("=================================");
							choice = Integer.parseInt(sc.nextLine());
							if (choice == 0) {
//								System.out.println(backToMenuMsg);
								break;
							} else if (choice == 1) { // 1. 게시글 목록 보기
								while (true) {
									boardVO = new BoardVO();
									System.out.println("게시글 목록");
									boardDAO.selectAll().forEach(
											v -> System.out.println(v.getBoardId() + " | " + v.getBoardTitle()));
									System.out.println("q입력 시 게시판 메뉴로.\n열람할 게시글 번호 입력 : ");
									temp = sc.nextLine();
									if(temp.equals("q")) {
										System.out.println(backToMenuMsg);
										break;
									}else {
										choice = Integer.parseInt(temp);
										boardVO.setBoardId(Long.parseLong(choice + ""));
										boardDAO.select(boardVO.getBoardId());
									}
									
								}
								
							}

							// // 댓글 서비스

							// 2. 글쓰기

						}
					}

				}
			}
			if (choice == 3) {
				sc.close();
				break;
			}
		}

	}
}
