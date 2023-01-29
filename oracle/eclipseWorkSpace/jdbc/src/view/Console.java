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
		String[] arBeforeMenu = { "Ȩ", "�α���", "ȸ������", "â �ݱ�" }, arAfterMenu = { "Ȩ", "�α׾ƿ�", "�Խ���", "â�ݱ�" },
				boardMenu = { "Ȩ", "�Խñ� ��� ����", "�۾���" };
		String beforeMenuMsg = arToMsg(arBeforeMenu), afterMenuMsg = arToMsg(arAfterMenu),
				boardMenuMsg = arToMsg(boardMenu);
		String inputErrMsg = "�߸��� �Է��Դϴ�.", backToMenuMsg = "���θ޴��� ���ư��ϴ�.", backToLoginMsg = "�α��� �������� ���ư��ϴ�.",
				backToJoinMsg = "ȸ������ �������� ���ư��ϴ�.", doneJoinMsg = "ȸ�������� �Ϸ�Ǿ����ϴ�.", welcomeLogin = "���� �α��� �����Դϴ�.";
		String inputIdMsg = "���̵�: ", inputPwMsg = "��й�ȣ: ", failLoginMsg = "���̵� Ȥ�� ��й�ȣ�� �߸��Ǿ����ϴ�.";
		String joinMenuMsg = "ȸ������ �������Դϴ�. �ʿ��� ������ �Է��ϼ���.", checkIdFalseMsg = "�̹� �����ϴ� ���̵��Դϴ�. �ٽ� �Է��� �ּ���.";
		String temp = null, temp2 = null;
		String inputNameMsg = "�̸� : ", inputPhoneMsg = "�ڵ��� ��ȣ : ", inputEmailMsg = "�̸��� : ",
				inputChoiceMoreInfoMsg = "(����)�߰� ������ �Է��Ͻðڽ��ϱ�?";
		String inputNicknameMsg = "�г��� �Է�(�ߺ� ����) : ", inputAddressMsg = "�ּ� �Է� : ",
				inputBirthMsg = "�������(yyyymmdd) �Է� : ";
		String additionalInputMsg = "�߰����� �Է� �������Դϴ�.\n�Է��� ������ ������ Enter�� ���� �Է��� �ǳʶټ���.";
		String insertErrMsg = "ȸ�����Կ� �����߽��ϴ�.\n���θ޴��� ���ư��ϴ�.", logoutMsg = "�����ϰ� �α׾ƿ��մϴ�.";
		boolean didLogin = false;
		int choice = 0;

//		IntStream.range(0, arBeforeMenu.length).map(i -> i + ". " + arBeforeMenu[i] + "\n").forEach(System.out::println);
//		for (int i = 0; i < arBeforeMenu.length; i++) {
//			beforeMenuMsg += i + ". " + arBeforeMenu[i] + "\n";
//		}

		while (true) {

			// �޴�
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
			// �α��� ��
			if (!didLogin) {
				// // �α��� ����
				userVO = new UserVO();
				if (choice == 1) {
					while (!didLogin) {
						System.out.print(inputIdMsg);
						userVO.setUserIdentification(sc.nextLine());

						System.out.print(inputPwMsg);
						userVO.setUserPassword(sc.nextLine());

						// �α��� ������
						if (userDAO.login(userVO.getUserIdentification(), userVO.getUserPassword())) {
							userVO = userDAO.select(userVO.getUserIdentification());
							didLogin = true;
							break;
						} else { // �α��� ���н�
							System.err.printf("%s\n%s\n", failLoginMsg, backToLoginMsg);
							break;
						}
					}
					// // ȸ������ ����
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

						System.out.print("(���Է�) " + inputPwMsg);
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
						System.out.println("\n1. �߰����� �Է�\n2. ȸ������ ����");
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

						// ȸ������ ����
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

				// // �α��� ��
			} else if (didLogin) {
				while (true) {

//					choice = Integer.parseInt(sc.nextLine());
					if (choice == 0) {
						System.out.println(backToMenuMsg);
						break;
					}
					// // �α׾ƿ� ����
					if (choice == 1) {
						System.out.println(logoutMsg);
						didLogin = false;
						break;
						// // �Խ��� ����
					} else if (choice == 2) {
						while (true) {
							System.out.println("�Խ���");
							System.out.println("=================================");
							System.out.println(boardMenuMsg);
							System.out.println("=================================");
							choice = Integer.parseInt(sc.nextLine());
							if (choice == 0) {
//								System.out.println(backToMenuMsg);
								break;
							} else if (choice == 1) { // 1. �Խñ� ��� ����
								while (true) {
									boardVO = new BoardVO();
									System.out.println("�Խñ� ���");
									boardDAO.selectAll().forEach(
											v -> System.out.println(v.getBoardId() + " | " + v.getBoardTitle()));
									System.out.println("q�Է� �� �Խ��� �޴���.\n������ �Խñ� ��ȣ �Է� : ");
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

							// // ��� ����

							// 2. �۾���

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
