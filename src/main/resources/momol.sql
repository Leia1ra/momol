DROP DATABASE momol;
CREATE DATABASE momol;

USE momol;
SHOW TABLES;

/* 로그인 */
INSERT INTO User(UID, Id, Pw, Nick, Name, Birth, Phone, Email, Gender)
VALUES ('ADMIN_000000', 'admin', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'ADMIN','관리자', now(), '000-0000-0000', 'admin@momol.com','none');
CREATE TABLE User (
    UID VARCHAR(20) NOT NULL PRIMARY KEY,
    Id VARCHAR(12) NOT NULL UNIQUE,
    Pw VARCHAR(60) NOT NULL,
    Nick VARCHAR(30) NOT NULL UNIQUE,
    Name VARCHAR(15) NOT NULL,
    Birth DATE NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(45) NOT NULL UNIQUE,
    Gender VARCHAR(6) NOT NULL,
    JoinDate DATETIME DEFAULT now()
); DESC User;
SELECT * FROM User;
DELETE FROM User;


DROP TABLE LoginFailure;
CREATE TABLE LoginFailure (
    UID VARCHAR(20),
    Id VARCHAR(12),
    Ip VARCHAR(45),
    loginTime DATETIME DEFAULT now(),
    FOREIGN KEY (UID) REFERENCES User(UID) ON DELETE CASCADE ON UPDATE CASCADE
); DESC LoginFailure;
SELECT * FROM LoginFailure;
SELECT count(Id) FROM LoginFailure WHERE Id='dl1197';


/*커뮤니티*/
create table board_category(
    catnum int not null,
    Category varchar(15) not null
);
INSERT INTO board_category (catnum, Category) VALUES (1, '담벼락');
INSERT INTO board_category (catnum, Category) VALUES (2, '추천해주세요');
INSERT INTO board_category (catnum, Category) VALUES (3, '다녀왔습니다');
INSERT INTO board_category (catnum, Category) VALUES (4, '나만의레시피');
INSERT INTO board_category (catnum, Category) VALUES (5, '위시리스트');

CREATE TABLE board (
    num INT NOT NULL PRIMARY KEY ,
    catNum INT NULL,
    UID VARCHAR(20) NOT NULL,
    title VARCHAR(100) NULL,
    writeTime DATETIME DEFAULT now(),
    content LONGTEXT NULL,
    views INT NULL DEFAULT 0,
    deleted BOOLEAN NULL DEFAULT FALSE
); desc board;
SELECT * FROM board;
CREATE TABLE comments (
    UID2 VARCHAR(20) NOT NULL,
    num INT NOT NULL,
    UID INT NULL,
    writeTime DATETIME NULL DEFAULT now(),
    content LONGTEXT NULL,
    likes INT NULL DEFAULT 0,
    deleted BOOLEAN NULL DEFAULT FALSE
);
INSERT INTO board(num, catNum, UID, title, content) VALUES (1,1,'BUSI_20231217 000001', '안녕하세요','반갑고 어서오고')


/*사업자 테이블*/
DROP TABLE business;
CREATE TABLE business (
    bizNo VARCHAR(50) PRIMARY KEY,
    UID VARCHAR(20) NOT NULL,
    place VARCHAR(50),
    other TEXT,
    address TEXT,
    date VARCHAR(30),
    time TEXT,
    lastTouch DATETIME DEFAULT now(),
    approved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (UID) REFERENCES user(UID) ON DELETE CASCADE ON UPDATE CASCADE
); DESC business;
SELECT * FROM business;
INSERT INTO business(UID, place, other, address, date, time)
VALUES ('BUSI_20231215 000000', '장소임', '오더가 뭐임', '주소', '영업일', '영업시간');
DELETE FROM business WHERE UID='BUSI_20231211 000000';


DROP TABLE biMenu;
CREATE TABLE biMenu (
    bizNo VARCHAR(50) NOT NULL,
    subject VARCHAR(100) UNIQUE ,
    content VARCHAR(300),
    FOREIGN KEY (bizno) REFERENCES business(bizno) ON DELETE CASCADE ON UPDATE CASCADE
); DESC biMenu;
SELECT * FROM biMenu;
DELETE FROM biMenu;


/* 칵테일 테이블 */
CREATE TABLE liquor_refi (
    UID VARCHAR(20) NOT NULL,
    ing_name VARCHAR(500) NOT NULL,
    save_time DATETIME DEFAULT now() NOT NULL,
    FOREIGN KEY (UID) REFERENCES User(UID)
);
INSERT INTO liquor_refi (UID, ing_name, save_time) VALUES ('GENE_20231218 000000', '맥주,소주', '2023-12-18 01:46:07');


CREATE TABLE baseTag (
    tagNo INT PRIMARY KEY AUTO_INCREMENT,
    tagName VARCHAR(15) NOT NULL
); DESC baseTag;
SELECT * FROM baseTag;

CREATE TABLE tasteTag (
    tagNo INT PRIMARY KEY AUTO_INCREMENT,
    tagName varchar(15) NOT NULL
); DESC tasteTag;
SELECT * FROM tasteTag;

CREATE TABLE smellTag (
    tagNo INT PRIMARY KEY AUTO_INCREMENT,
    tagName varchar(15) NOT NULL
); DESC smellTag;
SELECT * FROM smellTag;

DROP TABLE ingredient;
CREATE TABLE ingredient (
    ing_num INT AUTO_INCREMENT PRIMARY KEY,
    ing_name VARCHAR(50) NOT NULL,
    ing_name_eng VARCHAR(30) NOT NULL,
    ing_photo TEXT NULL,
    ing_detail TEXT NOT NULL,
    ing_categ VARCHAR(15) NOT NULL,
    abv INT NULL/*,
    baseTag INT NULL default 0,
    tasteTag INT Null default 0,
    smellTag int null default 0,
    FOREIGN KEY (baseTag) REFERENCES baseTag(tagNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tasteTag) REFERENCES tasteTag(tagNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (smellTag) REFERENCES smellTag(tagNo) ON DELETE CASCADE ON UPDATE CASCADE*/
); DESC ingredient;
SELECT * FROM ingredient;

DROP TABLE cocktail;
CREATE TABLE cocktail (
    name VARCHAR(30) PRIMARY KEY,
    name_eng VARCHAR(30) NULL,
    ABV FLOAT NULL,
    cocktail_detail TEXT NULL,
    recipe TEXT NULL,
    cocktails VARCHAR(100) NULL,
    cocktail_img TEXT NULL,
    smellNo INT DEFAULT 0,
    baseNo INT default 0,
    tasteNo INT default 0/*,
    FOREIGN KEY (smellNo) REFERENCES baseTag(tagNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (baseNo) REFERENCES tasteTag(tagNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tasteNo) REFERENCES smellTag(tagNo) ON DELETE CASCADE ON UPDATE CASCADE*/
); DESC cocktail;
SELECT * FROM cocktail;

DROP TABLE cock_ingre;
CREATE TABLE cock_ingre (
    name VARCHAR(30) NOT NULL,
    ing_num INT NOT NULL,
    ing_amount VARCHAR(100) NULL,
    FOREIGN KEY (name) REFERENCES cocktail(name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ing_num) REFERENCES ingredient(ing_num) ON DELETE CASCADE ON UPDATE CASCADE
); DESC cock_ingre;
SELECT * FROM cock_ingre;

/* 비즈니스 사용자 더미데이터 */
INSERT INTO User(UID, Id, Pw, Nick, Name, Birth, Phone, Email, Gender)
VALUES
    ('BUSI_20231217 000001', 'dummy1', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy1','관리자', NOW(), '000-0000-0001', 'dummy1@momol.com', 'none'),
    ('BUSI_20231217 000002', 'dummy2', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy2','관리자', NOW(), '000-0000-0002', 'dummy2@momol.com', 'none'),
    ('BUSI_20231217 000003', 'dummy3', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy3','관리자', NOW(), '000-0000-0003', 'dummy3@momol.com', 'none'),
    ('BUSI_20231217 000004', 'dummy4', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy4','관리자', NOW(), '000-0000-0004', 'dummy4@momol.com', 'none'),
    ('BUSI_20231217 000005', 'dummy5', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy5','관리자', NOW(), '000-0000-0005', 'dummy5@momol.com', 'none'),
    ('BUSI_20231217 000006', 'dummy6', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy6','관리자', NOW(), '000-0000-0006', 'dummy6@momol.com', 'none'),
    ('BUSI_20231217 000007', 'dummy7', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy7','관리자', NOW(), '000-0000-0007', 'dummy7@momol.com', 'none'),
    ('BUSI_20231217 000008', 'dummy8', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy8','관리자', NOW(), '000-0000-0008', 'dummy8@momol.com', 'none'),
    ('BUSI_20231217 000009', 'dummy9', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy9','관리자', NOW(), '000-0000-0009', 'dummy9@momol.com', 'none'),
    ('BUSI_20231217 000010', 'dummy10', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy10','관리자', NOW(), '000-0000-0010', 'dummy10@momol.com', 'none'),
    ('BUSI_20231217 000011', 'dummy11', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy11','관리자', NOW(), '000-0000-0011', 'dummy11@momol.com', 'none'),
    ('BUSI_20231217 000012', 'dummy12', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy12','관리자', NOW(), '000-0000-0012', 'dummy12@momol.com', 'none'),
    ('BUSI_20231217 000013', 'dummy13', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy13','관리자', NOW(), '000-0000-0013', 'dummy13@momol.com', 'none'),
    ('BUSI_20231217 000014', 'dummy14', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy14','관리자', NOW(), '000-0000-0014', 'dummy14@momol.com', 'none'),
    ('BUSI_20231217 000015', 'dummy15', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy15','관리자', NOW(), '000-0000-0015', 'dummy15@momol.com', 'none'),
    ('BUSI_20231217 000016', 'dummy16', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy16','관리자', NOW(), '000-0000-0016', 'dummy16@momol.com', 'none'),
    ('BUSI_20231217 000017', 'dummy17', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy17','관리자', NOW(), '000-0000-0017', 'dummy17@momol.com', 'none'),
    ('BUSI_20231217 000018', 'dummy18', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy18','관리자', NOW(), '000-0000-0018', 'dummy18@momol.com', 'none'),
    ('BUSI_20231217 000019', 'dummy19', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy19','관리자', NOW(), '000-0000-0019', 'dummy19@momol.com', 'none'),
    ('BUSI_20231217 000020', 'dummy20', '$2a$10$6E9SJTlq9nxQ6ubsQfH/hO/1XJf9uZi2CG8oDHVY6ftokq2l/L/fq', 'dummy20','관리자', NOW(), '000-0000-0020', 'dummy20@momol.com', 'none');
INSERT INTO business(bizno,UID, place, other, address, date, time, approved)
VALUES
    ('dummy1','BUSI_20231217 000001', '장소1', '상세1', '주소1', '영업일1', '영업시간1', TRUE),
    ('dummy2','BUSI_20231217 000002', '장소2', '상세2', '주소2', '영업일2', '영업시간2', TRUE),
    ('dummy3','BUSI_20231217 000003', '장소3', '상세3', '주소3', '영업일3', '영업시간3', TRUE),
    ('dummy4','BUSI_20231217 000004', '장소4', '상세4', '주소4', '영업일4', '영업시간4', TRUE),
    ('dummy5','BUSI_20231217 000005', '장소5', '상세5', '주소5', '영업일5', '영업시간5', TRUE),
    ('dummy6','BUSI_20231217 000006', '장소6', '상세6', '주소6', '영업일6', '영업시간6', TRUE),
    ('dummy7','BUSI_20231217 000007', '장소7', '상세7', '주소7', '영업일7', '영업시간7', TRUE),
    ('dummy8','BUSI_20231217 000008', '장소8', '상세8', '주소8', '영업일8', '영업시간8', TRUE),
    ('dummy9','BUSI_20231217 000009', '장소9', '상세9', '주소9', '영업일9', '영업시간9', TRUE),
    ('dummy10','BUSI_20231217 000010', '장소10', '상세10', '주소10', '영업일10', '영업시간10', TRUE),
    ('dummy11','BUSI_20231217 000011', '장소11', '상세11', '주소11', '영업일11', '영업시간11', TRUE),
    ('dummy12','BUSI_20231217 000012', '장소12', '상세12', '주소12', '영업일12', '영업시간12', TRUE),
    ('dummy13','BUSI_20231217 000013', '장소13', '상세13', '주소13', '영업일13', '영업시간13', TRUE),
    ('dummy14','BUSI_20231217 000014', '장소14', '상세14', '주소14', '영업일14', '영업시간14', TRUE),
    ('dummy15','BUSI_20231217 000015', '장소15', '상세15', '주소15', '영업일15', '영업시간15', TRUE),
    ('dummy16','BUSI_20231217 000016', '장소16', '상세16', '주소16', '영업일16', '영업시간16', TRUE),
    ('dummy17','BUSI_20231217 000017', '장소17', '상세17', '주소17', '영업일17', '영업시간17', TRUE),
    ('dummy18','BUSI_20231217 000018', '장소18', '상세18', '주소18', '영업일18', '영업시간18', TRUE),
    ('dummy19','BUSI_20231217 000019', '장소19', '상세19', '주소19', '영업일19', '영업시간19', TRUE),
    ('dummy20','BUSI_20231217 000020', '장소20', '상세20', '주소20', '영업일20', '영업시간20', TRUE);


INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('B-52', 'B-52', 26, '미국의 폭격기 B-52에서 이름을 따온 칵테일로 뚜렷한 3개의 층이 특
징입니다. 얇게 도수 높은 술을 얹어서 불을 붙이면 플레이밍(Flaming) B-52라고 불립니다.', '1. 슈터 글라스에 칼루아 20ml를 붓는다.
2. 칼루아 위에 베일리스를 아주 조심스럽게 붓고 그랑 마니에르를 따른다.
3. 불을 붙여 서브하고, 불이 붙은 상태에서 긴 빨대로 마신다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/02.B52.jpg', 1, 1, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('BMW', 'BMW', 26, '베일리스(Baileys), 말리부(Malibu), 위스키(Whiskey)의 앞 글자를 따왔
습니다.', '1. 락 글라스에 얼음을 채운다.
2. 베일리스 45ml, 말리부 45ml, 위스키 45ml를 넣는다.
3. 잘 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/11.BMW.jpg', 1, 2, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('갓마더', 'Godmother', 34, '갓파더 칵테일과 짝을 이룬 칵테일로 위스키 대신 보드카가 사
용됩니다.', '1. 락 글라스에 얼음을 채운다.
2. 얼음 위에 보드카 35ml와 아마레토 35ml를 붓는다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/25.갓마더.jpg', 3, 2, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('갓파더', 'Godfather', 34, '스카치위스키와 아마레토가 잘 어우러진 풍부한 맛의 칵테일입
니다.', '1. 락 글라스에 얼음을 채운다.
2. 얼음 위에 스카치위스키 35ml, 아마레토 35ml를 붓는다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/24.갓파더.jpg', 2, 2, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('고진감래주', 'No pain, No gain', 4, '고생이 다하면 즐거움이 찾아온다는 한자성어 고진
감래의 의미를 가진 폭탄주. 마시면 소주의 쓴 맛 뒤에 달달한 콜라를 먹게되므로 고진감래라고 이름 붙여졌습니다.', '1. 소주잔 1에 콜라를 반만 따라서 맥주잔 안에 넣는다.
2. 소주잔 2에 소주를 반만 따라서 맥주잔 안에 있는 소주잔 1위에 포개어 놓는다.
3. 맥주로 맥주잔을 채우는데 소주잔에 들어가지 않도록 주의한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/68.No pain, No gain.jpg', 1, 5, 4);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('골드 러쉬', 'Gold Rush', 34, '설탕 시럽 대신 꿀을 첨가한 위스키 사워의 변형입니다.', '1. 버번위스키 60ml, 레몬 주스 20ml, 꿀 시럽 20ml를 섞는다.
                                                                                                           2. 잘 흔들어 얼음을 채운 락 글라스에 따른다.
                                                                                                           3. 레몬 조각이나 레몬 트위스트로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/26.골드러쉬.jpg', 3, 7, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('그래스호퍼', 'Grasshopper', 16, '초록색 때문에 메뚜기라는 이름이 붙여졌다. 1950-60년
대에 미국 남부 전역에서 인기를 얻었습니다.', '1. 셰이커에 각얼음을 채운다.
2. 크림 드 민트 그린 20ml, 크림 드 카카오 화이트 20ml, 크림 20ml를 넣는다.
3. 몇 초간 흔든 후 차가운 칵테일 글라스에 따른다.
4. 선택적으로 민트 잎으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/27.그래스호퍼.jpg', 4, 2, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('그린 멕시칸', 'Green Mexican', 24, '우크라이나 바텐더가 녹색 바나나리큐르를 사용해서
만들었지만 일반적인 멜론리큐어로 대체되었습니다.', '1. 콜린스 잔에 얼음을 채운다.
2. 데킬라 블랑코 90ml, 미도리 90ml를 넣고 잔의 나머지를 레몬 주스 약 45ml, 설탕 시럽 45ml로 채운다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/28.greenmexican.jpg', 6, 5, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('김렛', 'Gimlet', 32, '목공용 송곳이라는 이름은 송곳같이 날카롭게 찌르는 맛 때문에 붙
여졌습니다. 진 대신에 보드카를 사용하는 보드카김렛도 인기가 있습니다.', '1. 믹싱 글라스에 각얼음을 채운다.
2. 진 60ml, 라임 주스 15ml를 넣는다.
3. 선택적으로 설탕 시럽 15ml를 넣는다.
4. 잘 저어 차가운 칵테일 글라스에 따른다.
5. 라임 조각이나 라임 트위스트로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/21.김렛.jpg', 5, 9, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('깁슨', 'Gibson', 37, '진과 드라이 베르무트로 만들어 칵테일 어니언으로 장식됩니다.', '1. 셰이커에 얼음을 채우고 진 60ml, 드라이 베르무트 10ml를 넣는다.
2. 저어서 칵테일 글라스에 따른다.
3. 방울양파로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/20.깁슨.jpg', 4, 10, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('꿀주', 'Honey Cocktail', 16, '가수 다비치의 강민경이 쇼프로에서 소개하면서 유명해진
소맥 중 하나. 맥주가 섞여 색이 변하는 순간 한번에 마셔야 진정한 꿀맛을 느낄 수 있습니다.', '1. 소주잔에 소주를 9의 비율로 채운다.
2. 맥주를 1의 비율로 채운다.
3. 맥주색이 전체적으로 퍼지는 순간 원샷!', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/66.Honey cocktail.jpg', 3, 5, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('네그로니', 'Negroni', 28, '이탈리아 네그로니 백작이 즐겨마시던 식전주에서 이름을 따왔
다는 유래가 있습니다.', '1. 락글라스에 얼음을 채운다.
2. 얼음 위에 진 30ml, 스위트 베르무트 30ml, 캄파리 30ml를 붓는다.
3. 오렌지 껍질로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/48.negroni.jpg', 6, 7, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('뉴욕 사워', 'New York Sour', 27, '위스키 사워 칵테일의 변형으로 서던 위스키 사워라고
도 합니다.', '1. 라이 위스키 (또는 버번 위스키) 60ml, 설탕 시럽 20ml, 레몬 주스 30ml를 셰이커에 붓는다.
2. 선택적으로 계란 흰자를 넣고 싶다면 먼저 얼음 없이 쉐이킹한다.
3. 얼음을 넣고 잘 흔든다.
4. 얼음을 채운 락 글라스에 따른다.
5. 드라이 레드와인 15ml를 조심스럽게 얹는다.
6. 선택적으로 레몬 껍질로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/49.new_york_sour.jpg', 2, 11, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('다이키리', 'Daiquiri', 34, '쿠바의 광산 이름에서 따왔으며 광산기술자가 만들어 마셨다
는 유래가 있습니다. 소설가 헤밍웨이가 즐겨마셨다고 합니다.', '1. 설탕 시럽을 사용할 경우 셰이커에 얼음을 넣는다.
2. 화이트 럼 60ml, 라임 주스 20ml, 설탕 2스푼 또는 설탕 시럽 10ml를 넣는다.
3. 설탕을 사용할 경우 얼음없이 셰이킹한 후 얼음을 넣고 다시 흔든 후 체에 거른다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/17.다이키리.jpg', 1, 1, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('더티 마티니', 'Dirty Martini', 32, '올리브의 풍미가 강조되는 마티니의 변형 칵테일입니
다.', '1. 믹싱 글라스에 각얼음을 채운다.
2. 보드카 60ml, 드라이 베르무트 10ml, 올리브 주스 10ml를 넣는다.
3. 잘 저어 차가운 칵테일 글라스에 따른다.
4. 올리브로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/18.더티마티니1.jpg', 2, 2, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('데킬라 선라이즈', 'Tequila Sunrise', 12, '일출을 닮았다고해서 붙여진 이름으로 그라데
이션으로 해 뜰 때의 붉은 하늘을 연상시킵니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 얼음 위에 데킬라 45ml, 오렌지 주스 90ml를 붓는다.
3. 그레나딘 시럽 15ml를 넣는다. 저으면 안됩니다.
4. 오렌지 슬라이스와 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/63.tequila_sunrise.jpg', 3, 10, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('라모스 피즈', 'Ramos Fizz', 11, '바텐더 헨리 찰스 칼 라모스에 의해 만들어진 장시간의
셰이킹이 필요한 칵테일입니다.', '1. 얼음이 없는 셰이커에 진 45ml, 라임 주스 15ml, 레몬 주스 15ml, 설탕 시럽 30ml를 붓는다.
2. 크림 60ml, 달걀 흰자 1개, 오렌지 플라워 워터 3대쉬, 바닐라 추출액 2방울을 넣는다.
3. 2분간 흔든 후 얼음을 넣고 1분간 더 흔든다.
4. 하이볼이나 허리케인 글라스에 따라내고 탄산수 25ml를 얹는다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/54.ramos_fizz.jpg', 6, 3, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('러스티 네일', 'Rusty Nail', 40, '식후에 마시는 칵테일로 온더락 또는 니트로 제공 될 수
 있습니다. ', '1. 락 글라스에 얼음을 채운다.
2. 스카치위스키 45ml, 드람부이 25ml를 붓는다.
3. 부드럽게 저어주고 레몬 트위스트로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/55.rusty_nail.jpg', 4, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('런던콜링', 'London Calling', 29, ' 2002년에 런던에서 만들어진 칵테일로 잘 알려진 변형
은 바나나콜링이 있습니다.', '1. 진 45ml, 드라이 셰리(혹은 드라이 베르무트) 15ml, 레몬 주스 10ml, 설탕 시럽 10ml를 붓는다.
2. 앙고스투라 비터 2대쉬를 넣고 잘 흔든다.
3. 차가운 닉앤노라 글라스 또는 마티니 잔에 따라낸다.
4. 자몽 트위스트로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/38.런던콜링.jpg', 5, 4, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('레이디킬러', 'Ladykiller', 12, '1984년 챔피언십 우승을 차지한 달콤하고 아름다운 칵테
일입니다.', '1. 칵테일 셰이커에 얼음을 채운다.
2. 진 30ml, 쿠앵트로 15ml, 살구 브랜디 15ml를 붓는다.
3. 패션프루트 주스 60ml, 파인애플 주스 60ml를 넣는다.
4. 잘 흔들어 섞은 후, 6~8개의 얼음을 넣은 하이볼 글라스에 따른다.
5. 오렌지 껍질, 체리, 민트 잎으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/37.레이디킬러.jpg', 4, 10, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('로이 로저스', 'Roy Rogers', null, '미국의 배우이자 가수인 로이 로저스의 이름을 딴 상
쾌한 무알콜 칵테일입니다.', '1. 하이볼 글라스에 얼음을 넣는다.
2. 그레나딘 시럽 10ml를 붓고 잔에 콜라를 채운다.
3. 잘 저어주고 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/70.Roy Rogers.jpg', 3, 5, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('롱아일랜드 아이스티', 'Long Island Iced Tea', 29, '4가지 기주가 사용되며 아이스티와
색상이 비슷해서 이름 붙여졌습니다. 한국에서는 롱티라고 줄여부릅니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 보드카, 데킬라 블랑코, 화이트럼, 쿠앵트로(또는 트리플섹), 진 15ml를 붓는다.
3. 레몬 주스 30ml, 설탕시럽 20ml를 넣는다.
4. 그 위에 콜라를 넣는다.
5. 선택적으로 레몬 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/39.롱아일랜드아이스티.jpg', 6, 11, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('마가리타', 'Margarita', 40, '유리잔 테두리에 소금을 두르는것이 특징인 인기 칵테일입니
다. 마르가리타라고도 불립니다. ', '1. 유리잔 테두리에 소금을 바른다.
2. 얼음을 채운 셰이커에 데킬라 블랑코 50ml, 쿠앵트로(혹은 트리플 섹) 20ml을 붓는다.
3. 라임 주스 15ml를 넣는다.
4. 잘 흔들어 마가리타 잔에 따른다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/42.margarita.jpg', 2, 6, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('마이타이', 'Mai Tai', 30, '타히티어로 최고라는 뜻이며 트로피컬 칵테일의 여왕이라 불립
니다.', '1. 셰이커에 얼음을 넣는다.
2. 화이트 럼 30ml, 다크 럼 30ml, 오렌지 큐라소 15ml를 붓는다.
3. 아몬드 시럽 15ml, 설탕 시럽 8ml, 라임 주스 30ml를 넣고
4. 잘 흔든 후 하이볼 잔에 따른다.
5. 파인애플 스피어나 라임 껍질로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/40.마이타이.jpg', 1, 10, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('마티니', 'Martini', 37, '칵테일의 왕으로 불리는 인기 칵테일이며, 다양한 마티니로 변형
됩니다. 진과 베르무트 비율에 대해서는 많은 의견이 있습니다.', '1. 셰이커나 믹싱 글라스에 얼음을 채운다.
2. 진 60ml, 드라이 베르무트 10ml를 붓는다.
3. 잘 저어 칵테일 글라스에 따른다.
4. 올리브로 장식하거나 유리잔에 레몬 껍질에서 기름을 짜낸다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/43.martini.jpg', 2, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('맨하탄', 'Manhattan', 34, '칵테일의 여왕으로 불리는 인기 칵테일입니다. ', '1. 믹싱 글
라스에 각얼음을 채운다.
2. 라이 위스키 50ml (또는 캐나다 위스키 20ml)에 스위트 베르무트 20ml를 넣고 섞는다.
3. 앙고스투라 비터 1대쉬를 추가한다.
4. 잘 저어 차가운 칵테일 글라스에 따른다.
5. 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/41.manhattan.jpg', 3, 7, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('머드슬라이드', 'Mudslide', 24, '블랙 러시안 칵테일의 변형으로 보통 컵 안쪽에 초코시럽
으로 장식합니다.', '1. 락 글라스에 얼음을 채운다.
2. 보드카 30ml, 커피 리큐르 30ml, 베일리스 30ml를 붓는다.
3. 믹싱 틴에서 살짝 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/47.mudslide.jpg', 4, 8, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('모스코 뮬', 'Moscow Mule', 11, '보통 구리로 만든 머그에 마시는 칵테일로 러시아인에게
구매했던 구리 머그에 새겨진 노새무늬 때문에 생긴 모스크바의 노새라는 별명이 이름이 되었습니다.', '1. 으깬 얼음을 채운 구리 머그에 보드카 45ml를 붓는다.
2. 진저비어 120ml와 라임 주스 10ml를 넣는다.
3. 라임 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/46.moscow_mule.jpg', 5, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('모히또', 'Mojito', 19, '쿠바에서 창조된 인기 칵테일로 소설가 헤밍웨이가 좋아한 칵테일
로 유명합니다. ', '1. 하이볼 글라스에 민트 몇 가지와 설탕 2티스푼을 넣는다.
2. 라임 주스 20ml를 넣고 민트잎을 섞는다.
3. 잔에 으깬 얼음을 채운다.
4. 화이트 럼 45ml를 붓고 소다수를 붓는다.
5. 민트 잎과 라임 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/45.mojito.jpg', 6, 9, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('미도리 사워', 'Midori Sour', 14, '멜론리큐르 미도리를 사용해서 만드는 사워 칵테일입니
다. ', '1. 락글라스에 얼음을 채운다.
2. 미도리 50ml, 레몬 주스 20ml, 설탕 시럽 20ml를 넣는다.
3. 부드럽게 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/44.midori_sour.jpg', 5, 10, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('바카디 칵테일', 'Bacardi Cocktail', 33, '주로 바카디 슈페리어로 만들고 식전주로 즐깁
니다.', '1. 셰이커에 각얼음을 채운다.
2. 화이트 럼 45ml, 라임 주스 20ml, 그레나딘 시럽 10ml를 넣는다.
3. 잘 흔들어 차게 식힌 칵테일 글라스에 따른다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/03.바카디칵테일.jpg', 4, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('버진 피나 콜라다', 'Virgin Pina Colada', null, '피나 콜라다의 무알콜 버전입니다.', '1. 믹서기에 으깬 얼음을 넣는다.
2. 코코넛 밀크(또는 코코넛 크림이나 코코넛 시럽) 30ml와 파인애플 주스 120ml를 추가한다.
3. 부드러워질 때까지 갈아서 허리케인 잔에 붓는다.
4. 휘핑크림으로 토핑하고 웨지 파인애플과 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/72.Virgin Colada.jpg', 3, 10, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('보드카 마티니', 'Vodka Martini', 35, '마티니 칵테일의 보드카 기반 변형입니다. 보드카
와 베르무트의 비율은 취향에 따라 달라질 수 있습니다.', '1. 믹싱 글라스에 각얼음을 채운다.
2. 보드카 55ml와 드라이 베르무트 15ml를 넣는다.
3. 잘 저어 칵테일 글라스에 따른다.
4. 레몬 껍질을 음료에 짜내고 그린 올리브로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/64.vodka_martini.jpg', 2, 9, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('보일러 메이커', 'Boilermaker', 9, '위스키와 맥주를 함께 마시는 양맥 폭탄주를 말합니다
. 맥주의 양은 취향에 따라 다를 수 있습니다.', '1. 맥주잔에 맥주 250ml를 붓는다.
2. 위스키 한 잔을 맥주 속으로 떨어뜨려 맥주잔 바닥에 서있도록 한다.
3. 칵테일을 한 번에 빠르게 마신다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/12.boilermaker.jpg', 2, 8, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('브랜디 에그노그', 'Brandy Eggnog', 16, '원래 에그노그는 브랜디만이 아니라 각종 증류주
나 와인 등도 베이스로 사용됩니다. 또한 알콜성분을 포함하지 않은 에그 노그도 있고 뜨겁게 핫 에그노그로도 마십니다.', '1. 셰이커에 각얼음을 채운다.
2. 브랜디 40ml, 우유 50ml, 설탕 시럽 10ml, 달걀노른자를 넣는다.
3. 잘 흔든 후 얼음과 함께 하이볼 글라스에 따른다.
4. 넛맥을 뿌린다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/13.브랜디에그노그.jpg', 6, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('브롱크스', 'Bronx', 36, '향긋하고 약간 달콤한 과일향이 나는 인기 칵테일입니다.', '1.
셰이커에 얼음을 채운다.
2. 진 60ml, 스위트 베르무트 15ml, 드라이 베르무트 10ml, 오렌지 주스 15ml를 넣는다.
3. 잘 흔들어 칵테일 글라스에 따른다.
4. 오렌지 껍질로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/14.브롱크스.jpg', 1, 7, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블랙 러시안', 'Black Russian', 33, '러시아의 전형적인 술인 보드카를 사용하고 커피 리
큐르의 검은색을 사용하여 그 이름을 얻었습니다.', '1. 락글라스에 얼음을 채운다.
2. 얼음 위에 보드카 50ml와 커피 리큐르 20ml를 붓는다.
3. 부드럽게 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/04.블랙러시안.jpg', 2, 6, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블러디 메리', 'Bloody Mary', 13, '피의 메리라는 이름은 영국의 메리 1세 여왕의 이름에
서 비롯되었다고도 합니다. ', '1. 하이볼 글라스에 얼음을 넣는다.
2. 우스터소스 2-3대쉬, 타바스코 1대쉬, 소금, 후추를 추가한다.
3. 얼음 위에 보드카 45ml, 토마토 주스 90ml, 레몬 주스 15ml를 붓는다.
4. 부드럽게 저어주고 샐러리 줄기나 레몬 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/05.블러디메리.jpg', 6, 5, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블로우 잡', 'Blow Job', 15, '잔에 손을 대지 않고 입만 이용해서 원샷으로 먹는 달콤한
슈터 칵테일입니다.', '1. 슈터 글라스에 아마레토 20ml를 붓는다.
2. 아마레토 위에 베일리스 20ml를 조심스럽게 붓는다.
3. 휘핑크림을 얹는다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/06.blowjob.jpg', 3, 10, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블루 라군', 'Blue Lagoon', 10, '파란색의 상큼한 칵테일로 푸른 호수라는 뜻입니다.', '1. 허리케인 글라스나 하이볼 글라스에 얼음을 넣는다.
2. 보드카 30ml와 블루 큐라소 30ml를 넣는다.
3. 레몬에이드 120ml를 올린다.
4. 잘 저어준 후 레몬 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/09.블루라군.jpg', 4, 4, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블루 오션', 'Blue Ocean', 17, '이국적인 스타일의 바다와 같은 아름다운 파란색의 달콤한
 칵테일입니다.', '1. 락 글라스나 하이볼 글라스에 얼음을 넣는다.
2. 보드카 30ml, 블루 큐라소 15ml, 설탕 시럽 15ml를 붓는다.
3. 자몽 주스 30ml를 추가합니다.
4. 잘 저어준 후 오렌지 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/10.블루오션.jpg', 5, 3, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블루 카미카제', 'Blue Kamikaze', 30, '카미카제 칵테일의 샷 버전이며, 롱 드링크로도 만
들 수 있습니다.', '1. 셰이커에 각얼음을 채운다.
2. 보드카 50ml, 블루 큐라소 50ml, 라임 주스 50ml를 넣는다.
3. 잘 흔들어서 샷을 만든다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/08.블루카미카제.jpg', 6, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('블루 하와이', 'Blue Hawaii', 11, '하와이 섬을 연상시키는 트로피컬 칵테일로 단맛에 비
해 상쾌한 맛이 강하다. 비슷한 이름의 블루 하와이안 칵테일은 코코넛 크림이 사용되며 단맛이 더 풍부하다.', '1. 셰이커에 얼음을 채운다.
2. 화이트 럼 20ml, 보드카 20ml, 블루 큐라소 15ml를 넣는다.
3. 파인애플 주스 90ml, 레몬 주스 15ml, 설탕 시럽 15ml를 넣는다.
4. 원하는 만큼 흔들거나 저어 허리케인 글라스에 붓는다.
5. 마라스키노 체리 또는 파인애플 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/07.블루하와이.jpg', 5, 2, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('사이드 카', 'Sidecar', 40, '사이드카 오토바이에서 이름을 따온 칵테일로 제1차 세계 대
전 중에 파리의 비스트로에서 만들어졌다고 합니다.', '1. 셰이커에 얼음을 채운다.
2. 꼬냑 또는 버번 위스키 50ml, 쿠앵트로 30ml, 레몬 주스 15ml를 넣는다.
3. 잘 흔들어 설탕 테두리가 있는 칵테일 글라스에 따른다.
4. 레몬 트위스트로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/60.sidecar.jpg', 6, 1, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('샹그리아', 'Sangria', 13, '와인에 여러가지 과일을 넣어 마시는 스페인의 대중적인 술입
니다. 피를 의미하는 스페인어 sangre에서 유래되었습니다.', '1. 피처에 적포도주나 백포도주 한 병을 붓는다.
2. 오렌지와 레몬은 웨지 모양으로 썰어 와인에 살짝 짜 넣는다.
3. 기호에 따라 다른 과일도 추가.
4. 설탕이나 꿀을 3~4티스푼 넣는다.
5. 브랜디 50ml, 진저 에일 또는 탄산수 200ml(선택적으로 음료를 더 부드럽게 만들고 싶다면)를 넣는다.
6. 선택적으로 얼음을 넣고 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/56.sangria.jpg', 4, 11, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('섹스온더비치', 'Sex on the beach', 14, '인기있는 칵테일로 다양한 변형이 있습니다. 모
던 섹스 온 더 비치에는 오렌지 주스 대신 파인애플 주스가 들어갑니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 보드카 40ml, 복숭아 리큐르 20ml, 오렌지 주스 40ml, 크랜베리 주스 40ml를 붓는다.
3. 살살 저어준 뒤 오렌지 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/59.sex_on_the_beach.jpg', 3, 2, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('셜리 템플', 'Shirley Temple', null, '미국의 아역배우 셜리 템플을 위해 만들어진 심플하
고 대중적인 무알콜 칵테일입니다.', '1. 콜린스 잔에 얼음을 채운다.
2. 진저 에일 60ml와 레몬에이드 60ml를 추가하거나 진저 에일만 120ml를 넣는다.
3. 그레나딘 시럽을 조금 추가한다.
4. 잘 저어주고 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/71.Shirley_temple.jpg', 6, 10, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('스크류드라이버', 'Screwdriver', 13, '이란에서 일하던 미국 석유 엔지니어가 몰래 보드카
를 오렌지 주스에 넣고 드라이버로 섞어먹었다는 유래가 있습니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 얼음 위에 보드카 50ml, 오렌지 주스 100ml를 붓는다.
3. 살살 저어준 뒤 오렌지 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/57.screwdriver2.jpg', 2, 11, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('실버 불렛', 'Silver Bullet', 40, '강한 스카치 위스키 향과 진 때문에 호불호가 있습니다
. 진과 스카치 위스키의 비율은 매우 다양할 수 있으며 슈터로도 만들 수 있습니다.', '1. 셰이커나 믹싱 글라스에 얼음을 채운다.
2. 스카치위스키 30ml, 진 60ml를 넣는다.
3. 저은 후 칵테일 글라스에 따른다.
4. 레몬 트위스트로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/61.silver_bullet.jpg', 1, 3, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('싱가포르 슬링', 'Singapore Sling', 11, '싱가포르 래플스 호텔의 롱바에서 바텐더가 당시
 공공장소에서 술을 마실수 없던 여성들을 위해 과일주스처럼 보이는 칵테일을 만들었다고 합니다.', '1. 얼음을 채운 셰이커에 레몬 반개(15ml)를 짜서 넣는다.
2. 다른 재료를 넣고 잘 흔든다.
3. 허리케인 잔에 따른다.
4. 파인애플 웨지와 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/62.singapore_sling.jpg', 2, 4, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('씨 브리즈', 'Sea Breeze', 8, '바닷바람이라는 뜻으로 주스가 많이 들어가는 인기 칵테일
입니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 보드카 40ml, 크랜베리 주스 120ml, 자몽 주스 30ml를 붓는다.
3. 부드럽게 저어주고 오렌지 제스트와 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/58.sea_breeze.jpg', 6, 5, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('애플 마티니', 'Apple Martini', 35, '애플티니(Appletini)라고도 불리며 보드카 대신 화이
트럼을 사용하기도 합니다.', '1. 믹싱 글라스에 얼음을 넣는다.
2. 보드카 40ml, 사과 리큐르 15ml, 쿠앵트로 15ml를 넣는다.
3. 잘 저어 차가운 칵테일 글라스에 따른다.
4. 사과 한 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/01.애플마티니.jpg', 3, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('에너자이저주', 'Energyju', 6, '편의점에서 쉽게 재료를 구해서 만들 수 있는 인기있는 소
주 칵테일입니다.', '1. 맥주잔에 각얼음을 넣는다.
2. 얼음 위에 소주, 파워에이드, 핫식스를 1:1:1의 비율로 붓는다.
3. 부드럽게 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/67.Energyju.jpg', 4, 6, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('에스프레소 마티니', 'Espresso Martini', 22, '약간의 카페인이 포함되는 마티니의 맛있는
 변형 칵테일입니다.', '1. 선택적으로 마티니 잔에 초콜릿 시럽을 뿌려 준비합니다.
2. 셰이커에 각얼음을 채운다.
3. 차가운 에스프레소 30ml, 보드카 45ml, 커피 리큐르 45ml를 붓는다.
4. 선택적으로 크림 드 카카오 화이트 30ml를 추가한다.
5. 흔들어 마티니 잔에 따른다.
6. 초콜릿 작은 조각, 코코아 가루 혹은 커피콩 3개로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/19.에스프레소마티니1.jpg', 6, 7, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('예거밤', 'Jager Bomb', 10, '예거마이스터와 에너지음료의 조합으로 핫식스를 사용해도 괜
찮습니다.', '1. 펍 글라스에 레드불 반 캔을 붓는다.
2. 예거마이스터 한 잔을 레드불을 넣은 글라스에 떨어뜨린다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/34.예거밤.jpg', 5, 10, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('오르가즘', 'Orgasm', 31, '리큐르만으로 만드는 칵테일로 변형으로 보드카가 더해지면 스
크리밍오르가즘(Screaming Orgasm) 칵테일이 됩니다.', '1. 락글라스에 얼음을 채운다.
2. 쿠앵트로 30ml, 베일리스 30ml, 그랑 마니에르 20ml를 얼음위에 붓는다.
3. 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/51.orgasm.jpg', 6, 8, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('올드 패션드', 'Old Fashioned', 33, '비터드슬링이라 불리던 양주, 설탕, 비터의 단순한
조합이 다양하게 변형되었지만 변형 후의 칵테일과 구분하기위해 옛날방식을 의미하는 이름으로 부르게되었습니다.', '1. 락 글라스에 각설탕을 넣고 앙고스투라 비터로 적신다. 오렌지비터를 추가해도 좋다.2. 물을 조금 넣고 설탕이 약간 녹도록 저어준다.
3. 잔에 얼음을 채우고 라이위스키나 버번을 45ml 넣어준다.
4. 오렌지 껍질로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/50.old_fashioned.jpg', 5, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('잭콕', 'Jack Coke', 10, '매우 간단하고 인기있는 칵테일 입니다. 여기에 싱글 몰트 스카
치 위스키를 낭비하는 것은 권장되지 않습니다.', '1. 콜린스 잔에 얼음을 채운다.
2. 얼음 위에 잭다니엘 50ml와 콜라 150ml를 붓는다.
3. 부드럽게 저어줍니다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/33.잭콕.jpg', 6, 9, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('젤리피쉬', 'Jellyfish', 23, '물속을 떠다니는 해파리를 닮은 모습에서 이름붙여졌습니다.', '1. 슈터 글라스에 크림 드 카카오 화이트 25ml를 붓는다.
2. 그 위에 아마레토 10ml를 살살 올린다.
3. 아마레토 위에 베일리스 10ml를 부드럽게 붓는다.
4. 그레나딘 시럽 몇 방울을 추가한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/35.jellyfish.jpg', 4, 10, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('진토닉', 'Gin Tonic', 13, '간단하게 만들 수 있고 진과 토닉워너의 비율은 취향에 따라
다양할 수 있습니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 얼음 위에 진 50ml, 토닉워터 100ml를 붓는다.
3. 부드럽게 저어주고 라임 조각으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/23.진토닉.jpg', 3, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('진피즈', 'Gin Fizz', 13, '라임 또는 레몬주스와 탄산수가 들어간 피즈 계열의 가장 인기
있는 칵테일. 달걀 흰자, 달걀 노른자, 스파클링 와인 등을 첨가하여 다양한 변형으로 응용됩니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 진 45ml, 레몬 주스 30ml, 설탕 시럽 10ml를 붓는다.
3. 탄산수를 넣는다.4. 레몬 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/22.진피즈.jpg', 2, 10, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('코스모폴리탄', 'Cosmopolitan', 26, '세련된 맛과 모던한 색감으로 뉴욕 여성들의 인기 칵
테일로 알려져있는데 상큼하고 달콤한 맛에 비해 높은 도수의 칵테일입니다.', '1. 셰이커에 얼음을 채운다.
2. 보드카 시트론 40ml, 쿠앵트로 15ml, 라임 주스 15ml, 크랜베리 주스 30ml를 넣는다.
3. 잘 흔들어 칵테일 글라스에 따른다.
4. 라임 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/15.코스모폴리탄.jpg', 1, 9, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('쿠바 리브레', 'Cuba Libre', 12, '자유로운 쿠바라는 뜻으로 쿠바 독립전쟁 당시 지원하던
 미군이 럼에 콜라를 넣어 마신것에서 유래되었습니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 얼음 위에 화이트 럼 50ml와 콜라 120ml를 붓는다.
3. 라임 주스 10ml를 넣는다.
4. 라임 슬라이스로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/16.쿠바리브레.jpg', 6, 11, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('키르', 'Kir', 11, '프랑스에서 식전주로 매우 인기가 있습니다. 샤도네이 화이트와인이 주
로 사용됩니다.', '1. 플루트 잔에 크림 드 카시스 10ml를 붓는다.
2. 드라이 화이트 와인 90ml를 얹는다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/36.키르.jpg', 2, 8, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('페인킬러', 'Painkiller', 10, '1970년대에 창조된 퍼서스럼을 사용한 시그니처 칵테일로
다크럼으로 대체가능합니다.', '1. 셰이커에 얼음을 채운다.
2. 다크 럼 60ml, 코코넛 밀크 30ml, 파인애플 주스 120ml, 오렌지 주스 30ml를 추가한다.
3. 잘 흔들어 하이볼 글라스에 따른다.
4. 넛맥으로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/52.페인킬러.jpg', 6, 7, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('피나 콜라다', 'Pina Colada', 15, '스페인어로 채에 거른 파인애플이라는 뜻으로 인기있는
 트로피컬 칵테일입니다.', '1. 블렌더나 셰이커에 으깬 얼음을 채운다.
2. 화이트 럼 50ml, 코코넛 크림 30ml, 파인애플 주스 50ml를 넣는다.
3. 부드러워질 때까지 흔들거나 갈아서 차가운 유리잔에 붓는다.
4. 웨지 파인애플과 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/53.pina_colada.jpg', 3, 11, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('하비 월뱅어', 'Harvey Wallbanger', 15, '캘리포니아 서퍼 하비가 즐겨마신 칵테일로 취해
서 벽에 부딪히는 하비의 모습에서 이름을 따왔습니다.', '1. 하이볼 잔에 얼음을 채운다.
2. 얼음 위에 보드카 45ml, 오렌지 주스 90ml를 붓는다.
3. 살살 저어준 후 갈리아노 15ml를 얹는다.
4. 오렌지 슬라이스와 마라스키노 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/29.하비웰뱅어.jpg', 6, 6, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('하이볼', 'Highball', 11, '위스키로 간단하게 만드는 최고의 인기 칵테일입니다.', '1. 하
이볼 잔에 얼음을 채운다.
2. 얼음 위에 위스키 60ml를 붓고 진저에일 또는 탄산수로 잔을 채운다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/30.하이볼.jpg', 4, 10, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('한라토닉', 'Halla Tonic', 6, '소주로 쉽게 만들 수 있는 하이볼. 제주도의 한라산 소주를
 사용하면 더 맛이 좋습니다. 화요 25도 짜리로 만드는 화요토닉도 있습니다.', '1. 하이볼잔에 각얼음을 넣는다.
2. 얼음위에 소주와 토닉워터를 1:2의 비율로 붓는다.(토닉워터는 반드시 단맛이 있는걸로!)
3. 레몬 슬라이스로 장식한다.(귀찮으면 레몬즙이나 라임즙을 대신 넣어도 좋음)', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/69.Halla Tonic.jpg', 5, 11, 1);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('핫 토디', 'Hot Toddy', 12, '보통 위스키에 꿀, 향신료를 넣어 만들고 뜨거운 물이나 따뜻
한 차를 넣어 뜨겁게 제공합니다.', '1. 아이리쉬 커피 잔 바닥에 꿀이나 설탕 1티스푼을 넣는다.
2. 위스키 45ml을 넣고 저어 꿀이나 설탕을 녹인다.
3. 계피스틱, 정향, 팔각 등의 향신료를 넣는다.
4. 레몬 주스 10ml를 선택적으로 추가하거나 레몬조각을 넣는다.
5. 뜨거운 물이나 홍차로 잔을 채운다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/31.핫토디.jpg', 6, 5, 2);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('허리케인', 'Hurricane', 26, '제2차 세계대전 시기에 만들어진 인기 트로피컬 칵테일로 허
리케인 글라스에 서빙한것에서 이름지어졌습니다.', '1. 칵테일 셰이커에 얼음을 채운다.
2. 화이트 럼 60ml와 다크 럼 60ml를 넣는다. 선택적으로 오버프루프 럼 30ml을 추가한다.
3. 패션프루트 주스 60ml, 오렌지 주스 30ml, 라임 주스 30ml를 넣는다.
4. 마지막으로 그레나딘 시럽 15ml와 설탕 시럽 15ml를 붓는다.
5. 잘 흔들어 얼음을 채운 허리케인 글라스에 따른다.
6. 오렌지 슬라이스와 체리로 장식한다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/32.허리케인.jpg', 5, 4, 3);
INSERT INTO momol.cocktail (name, name_eng, ABV, cocktail_detail, recipe, cocktails, cocktail_img, baseNo, tasteNo, smellNo) VALUES ('화이트 러시안', 'White Russian', 23, '크림을 첨가한 블랙 러시안 칵테일의 변형. 보드카
가 주재료이기 때문에 러시안이라는 이름이 붙었습니다.', '1. 락글라스에 각얼음을 넣는다.
2. 얼음 위에 보드카 50ml, 커피 리큐르 30ml, 크림 30ml를 붓는다.
3. 부드럽게 저어준다.', null, 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_COCK_MASTER/65.white_russian.jpg', 4, 11, 2);

/*베이스 태그*/
SELECT * FROM tastetag;
INSERT INTO momol.basetag (tagNo, tagName) VALUES (1, '진베이스');
INSERT INTO momol.basetag (tagNo, tagName) VALUES (2, '럼베이스');
INSERT INTO momol.basetag (tagNo, tagName) VALUES (3, '보드카');
INSERT INTO momol.basetag (tagNo, tagName) VALUES (4, '테킬라');
INSERT INTO momol.basetag (tagNo, tagName) VALUES (5, '브랜디');
INSERT INTO momol.basetag (tagNo, tagName) VALUES (6, '위스키');

/*향태그*/
INSERT INTO momol.smelltag (TagNo, TagName) VALUES (1, '달달한 향');
INSERT INTO momol.smelltag (TagNo, TagName) VALUES (2, '상큼한 향');
INSERT INTO momol.smelltag (TagNo, TagName) VALUES (3, '시원한 향');
INSERT INTO momol.smelltag (TagNo, TagName) VALUES (4, '한약 향');

/*맛태그*/
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (1, '시원함');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (2, '달달함');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (3, '부드러움');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (4, '새콤함');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (5, '심플함');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (6, '씁쓸함');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (7, '짭짤함');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (8, '위스키');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (9, '기름짐');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (10, '떫음');
INSERT INTO momol.tastetag (tagNo, tagName) VALUES (11, '민트맛');


/* 재료 레코드 */
SELECT * FROM ingredient;
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('아몬드 시럽', 'Almond syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/001.아몬드시럽
.png', '아몬드로 만들어 달콤하고 우디하며 아몬드 맛이 나는 믹싱 시럽. ', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('앙고스투라 비터', 'Angostura bitter', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/002.앙
고스투라비터90.png', '럼에 40~80여종의 약초와 향초를 사용해서 만든 유명한 비터로 몇방울만 사용하여 칵테일에 향을 더한다.', '강한도수',  '45' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('사과', 'Apple', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/003.사과60.png', '사과나무의
 열매로, 세계적으로 널리 재배되는 열매 가운데 하나', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('후추', 'Black pepper', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/004.후추70.png', '일
반적으로 음식에 사용되나 칵테일에도 첨가되는 향신료로 약한 스모키한 향과 함께 미묘한 허브 맛이 있습니다. ', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('샐러리', 'Celery', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/005.샐러리.png', '특유의
향을 가진 녹색 채소로 칵테일 장식으로 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('코코넛 크림', 'Coconut cream', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/006.코코넛크
림80.png', '잘게 썬 코코넛을 물과 함께 끓여서 만들어 코코넛 밀크보다 더 진하고 풍부한 맛입니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('코코넛 밀크', 'Coconut milk', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/007.코코넛밀크
80.png', '코코넛 과육에 따뜻한 물을 섞어 만든 달콤한 주스로 열대 음료에 많이 사용됩니다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('커피', 'Coffee', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/008.커피80.png', '로스팅한
커피콩과 물로 만든 음료로 아이리쉬 위스키와 혼합하여 아이리쉬 커피를 만드는 것이 유명합니다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('콜라', 'Cola', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/009.콜라90.png', '카페인과 미
묘한 바닐라 향이 가미된 달콤한 탄산 음료', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크랜베리 주스', 'Cranberry juice ', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/010.크랜
베리주스.png', '크랜베리를 착즙하여 만든 붉은색의 주스', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크림', 'Cream', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/011.크림80.png', '우유의 고
지방 성분으로 구성된 유제품으로 풍부하고 부드러운 질감을 가지고 있으며 우유보다 훨씬 진하다. 칵테일을 걸쭉하게 만드는 데 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('계란', 'Egg', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/012.계란.png', '칵테일에 사용
할 때 크림같고 부드러운 질감을 제공합니다. 노른자와 흰자를 구분하여 사용되기도 합니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('자몽', 'Grapefruit', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/013.자몽90.png', '단맛
이 적고 쓴맛과 신맛이 나는 감귤류 과일', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('자몽 주스', 'Grapefruit juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/014.자몽주스
.png', '자몽 과즙주스로 칵테일에 흔히 사용됩니다. ', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('그레나딘 시럽', 'Grenadine', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/015.그레나딘시
럽.png', '석류와 붉은 건포도로 만든 붉은 시럽으로 달콤한 풍미와 색 때문에 칵테일에 많이 사용됩니다. ', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('꿀', 'Honey', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/016.꿀90.png', '꽃과 과일 향을
 가진 달콤한 점성있는 액체 감미료', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('꿀 시럽', 'Honey syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/017.꿀시럽.png', '
설탕대신 꿀을 따뜻한 물에 섞어 만든 시럽', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('얼음', 'Ice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/018.얼음80.png', '거의 모든 칵
테일에 사용되어 음료를 차게 만들거나 복잡한 풍미를 더해줍니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('레몬', 'lemon', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/019.레몬80.png', '신맛이 나
는 노란색 과일로 칵테일의 쓴맛을 완화시키면서 산뜻한 맛을 내주며 장식으로 많이 사용됩니다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('레몬에이드', 'lemonade', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/020.레몬에이드90.png', '레몬 주스, 물 및 설탕으로 구성된 달콤한 레몬 맛의 음료', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('라임', 'Lime', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/021.라임90.png', '칵테일 장식
으로 많이사용되는 강한 신맛의 녹색 과일로 레몬보다 조금 작습니다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('마라스키노 체리', 'Maraschino cherry', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/022.
마라스키노체리80.png', '칵테일 체리라고 불리며, 설탕 시럽으로 코팅된 붉은색 체리입니다. 칵테일 장식으로 많이 사용됩니다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('우유', 'Milk', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/023.우유.png', '흰색 유제품으
로 칵테일에 부드러운 질감을 더해주는 믹서로 사용됩니다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('민트', 'Mint', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/024.민트90.png', '청량감있는
녹색 허브로 민트 잎은 신선하고 상쾌한 맛을 첨가하기 위해 다양한 칵테일에 사용되는데 새로 나온 잎이 3~4장 달린 끝부분을 사용합니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('올리브', 'Olive', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/025.올리브90.png', '짠맛의
 과일로 주로 드라이한 맛이 나는 칵테일에 장식으로 사용됩니다. 마티니가 가장 유명합니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('올리브 주스', 'Olive juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/026.올리브주스90.png', '올리브를 보존하는데 사용되는 짠 염수로 씁쓸하고 짠맛을 칵테일에 더할 수 있습니다. 더티마티니가 유명합니다.', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('오렌지', 'Orange', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/027.오렌지.png', '주황색
의 달콤한 감귤류 과일로 칵테일 장식에 사용됩니다. 슬라이스하거나 웨지로 사용한다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('오렌지 비터', 'Orange bitter', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/028.오렌지비
터90.png', '씁쓸한 오렌지 껍질의 엑기스를 사용한 비터로 칵테일에 몇 방울만 넣어 오렌지 향을 더한다.', '약한도수',  '28' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('오렌지 플라워 워터', 'Orange flower water', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/029.오렌지플라워워터80.png', '신선한 비터 오렌지 꽃을 맑고 향기롭게 증류한 것으로, 오렌지 맛과 강한 향으로 인해 칵테일의 재료로 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('오렌지 주스', 'Orange juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/030.오렌지주스
90.png', '오렌지의 과즙 주스로 다양한 칵테일에 사용됩니다.', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('파인애플', 'Pineapple', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/031.파인애플.png', '달콤하고 과즙이 많은 과일로 트로피컬 음료 장식에 잘 사용됩니다. 유럽에서는 아나나스(Ananas)라고 불린다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('파인애플 주스', 'Pineapple juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/032.파인
애플주스80.png', '파인애플의 달콤한 과일 주스로 열대 주스가 들어있는 다양한 음료에서 가장 일반적으로 사용됩니다.', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('레드불', 'Red bull', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/033.레드불80.png', '레
드불은 에너지 음료로 예거밤 칵테일에 예거 마이스터와 함께 사용됩니다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('소금', 'Salt', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/034.소금80.png', '음식이나 칵
테일에 짠맛을 첨가하는 소금은 마가리타 잔의 림을 코팅하는데 사용된다. 입자가 부드러운 소금을 사용하는 것이 좋다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('탄산수', 'Soda water', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/035.탄산수90.png', '
탄산가스와 무기염류를 함유한 음료수로 소다수는 감미료가 포함되지 않아 맛을 바꾸지않고 다양한 음료에 탄산과 물을 첨가할 수 있다. 위스키와 잘 어울리고 독한 술을 마실 때 사용한다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('설탕', 'Sugar', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/036.설탕70.png', '사탕수수에
서 생산 된 설탕은 칵테일에 단맛을 더하는데 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('설탕 시럽', 'Sugar syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/037.설탕시럽.png', '설탕에 물을 넣고 끓인 시럽으로 칵테일에 쉽게 단맛을 더할 수 있습니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('타바스코', 'Tabasco', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/038.타바스코90.png', '매운 맛과 향이 나는 소스로 타바스코 페퍼와 식초 및 소금으로 만들어집니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('토마토 주스', 'Tomato juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/039.토마토주스
.png', '토마토를 착즙하여 만든 주스', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('토닉워터', 'Tonic water', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/040.토닉워터90.png', '쓴맛이 나는 탄산음료로 소다수에 키나나무에서 얻어낸 엑기스인 키니네(퀴닌)와 기타 재료를 섞어 만든다. 진과 잘 어울린다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('바닐라 추출액', 'Vanilla Extract', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/041.바닐
라추출액80.png', '바닐라 빈을 알코올에 담가 만든 향료로 칵테일에 단맛과 바닐라 향을 더할 때 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('물', 'Water', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/042.물.png', '물은 칵테일 믹서
로 자주 사용되지 않지만 때로는 스카치 또는 버번과 혼합되어 도수를 약하게하고 더 복잡한 맛을 냅니다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('휘핑 크림', 'Whipped cream', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/043.휘핑크림.png', '많은 거품으로 부드러운 질감을 더해주는 크림으로 설탕과 바닐라가 추가됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('우스터 소스', 'Worcestershire sauce', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/044.우
스터소스90.png', '마늘, 간장, 양파 등이 들어간 어두운 색의 소스로 1840년대 고기를 위한 조미료 소스로 인기가 있었습니다. 블러드 메리에 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('넛맥', 'Grated Nutmeg', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/045.넛맥80.png', '타
원형 모양으로 육두구라고 불리는 넛맥은 음료에 풍미를 더해주는데, 칵테일에는 주로 갈아서 사용된다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('방울양파', 'Silverskin Onion', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/046.방울양파80.png', '일반 양파보다 매운맛이 덜한 작은 크기의 방울양파를 소금과 식초로 혼합하여 절여 칵테일 어니언으로 불리며, 칵테일 장식으로 사용되거나 칵테일에 풍미를 더합니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('패션프루트 주스', 'passion fruit juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/047.패션프루트주스90.png', '패션프루트(백향과)를 착즙한 달콤한 이국적인 주스로 열대 칵테일의 중요한 재료입니다.', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('아마레토', 'Amaretto', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/001.아마레토90.png',
                                                                                                     '살구씨를 물에 침지, 증류하여 아몬드향과 비슷한 향을 만들어 향초 성분과 혼합하고 시럽을 첨가해서 만든 이탈리아 리큐르로 아몬드 향이 강합니다.', '약한도수',  '28' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('사과 리큐르', 'Apple liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/002.사과리큐
르.png', '사과를 증류하여 만든 리큐르로 병에 담기 전에 설탕을 첨가한다.', '약한도수',  '15' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('살구 브랜디', 'Apricot brandy', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/003.살구브랜
디.png', '브랜디에 살구와 여러 가지 향료를 첨가하여 당분과 함께 침지법을 사용하여 만든 리큐르로 살구향과 살구씨에서 우러난 아몬드향이 특징입니다.', '약한도수',  '24' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('베일리스', 'Baileys', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/004.베일리스.png', '아
이리쉬 위스키와 크림, 벨기에 초콜릿으로 만든 크림 리큐르로 달콤하면서도 부드러운 맛이 특징입니다.', '약한도수',  '17' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('맥주', 'Beer', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/005.맥주.png', '보리나 기타
곡물을 발효시켜 만든 4~6% 도수의 술로 맥주의 역사는 약 9500년으로 거슬러 올라갑니다.', '약한도수',  '5' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('베네딕틴 D.O.M', 'Benedictine D.O.M', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/006.베
네딕틴.png', '다양한 약초와 허브, 과일 껍질 등으로 만들어진 달콤한 허브 향의 꼬냑 기반 프랑스 리큐르. D.O.M은 라틴어로 Deo Optimo Maximo(데오 옵티모 맥시모)의 약어로 최대 최선의 신에게라는 뜻으로 카라멜과 꿀이 첨가된다
.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('블루 큐라소', 'Blue curacao', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/007.블루큐라소
.png', '오렌지 향이 나는 달콤한 맛의 파란색 리큐어로 라라하 귤 열매의 껍질로 만든 큐라소 리큐르에 식용 색소로 색을 냈다. ', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('버번 위스키', 'Bourbon whiskey', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/008.버번위
스키.png', '옥수수와 호밀로 만든 아메리칸 위스키의 한 종류로, 미국 켄터키주의 버번지방을 중심으로 생산된 옥수수를 51% 이상 사용하여 만든 증류주다. ', '강한도수',  '45' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('브랜디', 'Brandy', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/009.브랜디.png', '와인을
증류하여 만든 술로 브랜디는 꽃 향미를 가지고 있으며 증류주에 독특한 향과 색상을 주기 위해 일반적으로 나무 통에서 숙성됩니다. 숙성시간이 길수록 품질이 향상됩니다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('캄파리', 'Campari', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/010.캄파리.png', '과일과
 허브에 알코올과 물을 주입하여 만든 캄파리는 쓴 허브 향이 나는 20~28% 도수의 이탈리아 리큐르다. 비터이지만 식전주로 많이 사용된다.', '약한도수',  '25' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('체리 브랜디', 'Cherry brandy', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/011.체리브랜
디.png', '레드 체리 주스로 만들어 달콤하고 진한 체리향이 나는 리큐르로 16세기부터 프랑스에서 만들어졌다.', '약한도수',  '24' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('커피 리큐르', 'Coffee liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/012.커피리큐
르.png', '커피맛이 나는 리큐르로 칼루아와 티아 마리아가 유명하다.', '약한도수',  '16' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('꼬냑', 'Cognac', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/013.꼬냑90.png', '프랑스 꼬
냑 지방에서 생산되는 브랜디로 2번 증류하고 오크통에서 최소 2년 동안 숙성됩니다. 꼬냑 지방의 포도주가 맛이 빨리 변하기 때문에 오랬동안 저장할 수가 없어 증류했던 것이 오늘날 브랜디를 만들게되었습니다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('쿠앵트로', 'Cointreau', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/014.쿠앵트로90.png', '쿠앵트로는 1849년 제과업자인 아돌프 쿠앵트로와 그의 형제 에두아르 장 쿠앵트로가 처음 만든 달콤한 오렌지 맛 리큐르로 오렌지 계열의 리큐르 중 최고급이다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크림 드 카카오 화이트', 'Creme de cacao white', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/015.카카오화이트.png', '카카오 열매와 바닐라 추출물을 증류하여 만든 달콤한 초콜릿 리큐르. 화이트는 달콤한 카카오의 향과 맛을 가지면서 칵테일 색상에 영향을 주지않는다.', '약한도수',  '24' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크림 드 카시스', 'Creme de cassis', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/016.크림
드카시스.png', '블랙커런트 추출액과 증류주를 혼합하여 만든 리큐르로 달콤하고 약간 산미가 있고 매우 진하며 시럽처럼 고농축이다.', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크렘 드 민트 그린', 'Creme de menthe green', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/017.민트그린.png', '시원하고 부드러운 맛을 지닌 박하잎에서 추출한 농축액으로 만들어진 페퍼민트 리큐르로 그린은 색을 내는데 주로 사용한다. ', '약한도수',  '24' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('다크 럼', 'Dark rum', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/018.다크럼.png', '사탕
수수에서 설탕을 만들고 난 찌꺼기인 당밀(Molasses)를 이용하여 발효, 증류시켜 만든 증류주. 다크럼은 스모키한 풍미를 위해 그을린 오크통에서 숙성되어 짙은 갈색에 맛과 향이 매우 강하게 느껴진다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('드람부이', 'Drambuie', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/019.드람부이90.png',
                                                                                                     '몰트 위스키, 허브, 향신료 및 꿀로 만든 달콤한 스코트랜드 리큐르. 스코틀랜드의 고대 게릭어인 Dram Buid Heach로 사람을 만족시키는 음료라는 뜻이다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('드라이 셰리', 'Dry sherry', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/020.드라이셰리.png', '선택된 포도 품종의 완전한 발효로 생산되는 15-17%도수의 와인', '약한도수',  '16' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('드라이 베르무트', 'Dry vermouth', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/021.드라이
베르무트.png', '베르뭇, 버무스라 불리며 와인에 40여종의 약재가 포함된 혼성 포도주로 원래 식전주로 만들었찌만 칵테일용으로 많이 이용된다. 드라이 베르무트는 화이트와인을 베이스로 초근목피향 첨가로 씁쓸한 맛이 난다.', '약
한도수',  '18' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('갈리아노', 'Galliano', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/022.갈리아노.png', '
감초, 아니스, 바닐라 향을 함유한 달콤한 이탈리아 허브 리큐르로 도수는 약 30~42%이고 길쭉한 병에 담겨있다. 이탈리아 전쟁 영웅 Giuseppe Galliano의 이름에서 유래되었다.', '약한도수',  '30' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('진', 'Gin', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/023.진.png', '보리 또는 옥수수와
 같은 곡물을 증류하여 만든 술. 특유의 향을 지닌 주니퍼 베리로인해 소나무향이 나는 증류주이다. 주니퍼(Juniper)의 불어 주니에브르(Genievre)가 네덜란드로 전해져 제네바(Geneva)가 되고 영국으로 건너가 진(Gin)이 되었다.', '
강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('진저 에일', 'Ginger ale', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/024.진저에일70.png', '소다수에 생강의 풍미를 곁들인 탄산음료로 위스키, 브랜디, 진과 함께 자주 사용된다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('진저 비어', 'Ginger beer', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/025.진저비어80.png', '강한 생강향이 나고 진저 에일과 비슷한 맛의 탄산 음료. ', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('그랑 마니에르', 'Grand marnier', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/026.그랑마
니에르90.png', '꼬냑 베이스에 열대 오렌지 에센스의 독특한 조화를 이룬 오렌지 맛 브랜디 리큐르. 짙은 황금색과 갈색톤을 띄며 오렌지와 꽃의 섬세한 향기로 은은한 뒷 맛을 즐길 수 있다.', '약한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('잭 다니엘', 'Jack daniels', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/027.잭다니엘.png', '잭 다니엘은 아메리칸 위스키 중에 테네시 위스키에 속하는 브랜드이다. 1866년 미국 테네시주의 린치버그에 재스퍼 뉴튼 잭 다니엘이 설립한 양조장에서 처음 탄생했다. 주로 잭콕이라는 칵테일의 형태로 콜라 등의 음료수와 함께
 마시는 게 일반적이다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('예거 마이스터', 'Jagermeister', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/028.예거마이
스터.png', '56가지 허브, 열매, 향료 등으로 만들어 특유의 허브향과 강한 단맛이 나는 짙은 갈색의 리큐르. 1934년 독일의 마스트-예거마이스트사에서 개발되었고 예거마이스트는 독일의 산림 관리인 또는 사냥터 관리인을 부르는 말
이다.', '강한도수',  '35' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('칼루아', 'kahlua', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/029.칼루아.png', '럼 기반
의 멕시코의 커피 리큐르이며 Acolhua(사람들의 집)을 의미합니다.', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('말리부 코코넛 럼', 'Malibu', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/030.말리부.png', '자메이카산 라이트 럼에 카리브해 지역에서 생산되는 코코넛과 당분을 첨가하여 만든 무색 투명하고 달콤한 코코넛 맛의 화이트 럼', '약한도수',  '21' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('미도리', 'Midori', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/031.미도리.png', '달콤하
고 밝은 녹색의 멜론맛 리큐르로 1978년 일본에서 만들어졌고 일본어로 초록색을 의미합니다.', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('오렌지 큐라소', 'Orange curacao', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/032.오렌지
큐라소.png', '남미 베네주엘라 큐라소섬에서 생산되는 쓴맛의 강한 오렌지 껍질을 브랜디나 그 밖의 화주에 첨가하여 감미를 곁들인 30% 도수의 오렌지 리큐르입니다.', '약한도수',  '39' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('오버프루프 럼', 'Over-proof rum ', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/033.오버
프루프럼.png', '일반 럼주 도수 2배인 매우 높은 60~75.5%를 가지고있다. 높은 알코올 함량으로 인화성이 매우 강하므로 불과 열로부터 멀리 떨어진 곳에 보관해야하고 불타는 샷으로 서빙할 때 사용된다.', '강한도수',  '70' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('레드 와인', 'Red wine', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/034.레드와인.png', '적포도주로 적포도의 포도 알맹이, 껍질, 씨까지 포함하여 즙을 낸 후 발효시켜 만든 발효주. 붉은 빛을 띄고 탄닌성분이 적다. 레드 와인의 대표 종류는 멜로, 피노누아, 까베르네 쇼비뇽 및 쉬라즈입니다. ', '약한도수',  '14' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('라이 위스키', 'Rye whiskey', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/035.라이위스키.png', '라이(호밀) 51% 이상을 주재료로 곡물로 만든 위스키로, 발아시키지 않은 호밀과 맥아 또는 발아 호밀을 혼합해 만든 증류주입니다. 버번위스키와 색이 비슷하지만 맛과 향이 다릅니다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('스카치 위스키', 'Scotch whiskey', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/036.스카치
위스키.png', '스코틀랜드에서 생산된 위스키의 총칭이며 위스키 생산량의 양 60%를 생산하고 있다. 보리 몰트(Malt) 60%와 기타 곡류 40%를 혼합하여 엿기름에 의해 당화, 발효시켜 스코틀랜드에서 단식 증류기로 증류하여 최소한 3년
간 오크통에 넣어 저장 숙성시킨다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('데킬라 블랑코', 'Tequila blanco', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/037.데킬라
블랑코.png', '데킬라는 용설란의 일종으로 멕시코 데킬라 지방에서만 재배되는 아가베로 만든 술로 데킬라 블랑코는 화이트 데킬라로 불리며 무색, 투명하여 칵테일에 주로 사용됩니다. 가볍고 샤프한 맛으로 용설란을 발효시킨 후 단
식증류기로 두 번 증류하여 스테인레스 통에 단기간 저장한다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('보드카', 'Vodka', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/038.보드카.png', '주로 곡
물과 감자의 증류로 만들어지는 보드카는 무색, 무미, 무취의 특징을 갖고있다. 러시아어로 Voda Boa, 생명의 물에서 유래 되었다. 12세기경 러시아의 농민에 의해 창안된 술로서 증류주로서 오랜 역사를 가지고 있다. 어떠한 음료나
부재료와 잘 조화되기 때문에 칵테일의 기주로 많이 사용된다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('보드카 시트론', 'Vodka citron', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/039.보드카시
트론.png', '보드카에 여러 가지 과실을 첨가하여 향과 맛을 더해 일반 보드카보다 약간 낮은 도수를 가진 보드카로 오렌지, 레몬, 라임 등의 감귤류가 사용됩니다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('위스키', 'Whiskey', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/040.위스키.png', '위스키
는 12세기경 처음으로 아일랜드에서 보리를 발효하여 증류시킨 술로 그 이후 스코틀랜드에도 유입되어 품질개발과 함께 전세계로 많이 알려지게 되었다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('화이트 럼', 'White rum', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/041.화이트럼.png',
                                                                                                     '사탕수수에서 설탕을 만들고 난 찌꺼지인 당밀(Molasses)를 이용하여 증류시켜 만든 증류주로 화이트 럼은 라이트 럼, 실버 럼으로도 알려져있다. 무색투명한 럼으로 맛이 부드러워 칵테일의 기주로 많이 사용된다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('화이트 베르무트', 'Dry vermouth', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/042.화이트
베르무트.png', '베르뭇, 버무스라 불리며 와인에 40여종의 약재가 포함된 혼성 포도주로 원래 식전주로 만들었찌만 칵테일용으로 많이 이용된다. 화이트 베르무트는 바닐라와 클로버 맛과 함께 오레가노와 백리향의 강력한 아로마를
가지고있다. ', '약한도수',  '18' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('화이트 와인', 'White wine', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/043.화이트와인.png', '백포도주로 백포도, 적포도의 껍질을 제거한 후 포도즙만을 발효시켜 만든 발효주. 노란색을 띄며 샤도네, 소비뇽블랑, 리즐링이 유명합니다. ', '약한도수',  '10' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('스위트 베르무트', 'Sweet Vermouth', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/044.ㅅㅡ
ㅇㅟㅌㅡㅂㅔㄹㅡㅁㅜㅌㅡ.png', '베르뭇, 버무스라 불리며 와인에 40여종의 약재가 포함된 혼성 포도주로 원래 식전주로 만들었지만 칵테일용으로 많이 이용된다. 스위트 베르무트는 레드 베르무트로 불리며, 레드와인을 베이스로 설탕이 첨
가되어 단맛이 난다. ', '약한도수',  '18' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('복숭아 리큐르', 'Peach liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/045.복숭아
리큐르.png', '복숭아 추출물과 신선한 향을 보존하기 위한 감미로운 브랜디를 결합하여 만든 리큐르로 설탕이 추가되었다.', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('사이다', 'Sprite', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/048.사이다80.png', '액상
과당, 설탕, 레몬향, 라임향, 구연산 등을 원료로 만든 무색 투명한 카페인이 없는 탄산음료로 7Up과 스프라이트와 같이 사용된다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('사과 주스', 'Apple juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/049.사과주스70.png', '사과를 착즙한 과즙주스', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('바질', 'Basil', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/050.바질90.png', '허브의 왕
이라고 알려진 향신료로 진 및 보드카 기반 칵테일에 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('홍차', 'Black tea', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/051.홍차90.png', '차나무
의 찻잎을 우려내어 강한 허브 맛이 나는 차. 다양한 칵테일에 사용됩니다.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('블랙 베리', 'blackberry', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/052.블랙베리80.png', '약간 쓴 뒷맛이 있는 작고 달콤한 과일. 블랙베리는 블랙베리 모히또에 사용됩니다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('버터', 'Butter', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/053.버터90.png', '발효유나
생우유 또는 생크림을 유지방과 버터밀크가 분리될 때까지 휘저어 만든 유제품.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('칠리 고추', 'Chili', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/054.고추.png', '칠리는
맛과 향을 위해 음식과 칵테일에 사용되는 달콤하고 매운 고추입니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('초콜릿', 'Chocolate', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/055.초콜릿90.png', '카
카오 나무의 씨로 만든 풍부하고 어둡고 단맛이 나는 식재료. 초콜릿은 달콤하고 부드러우며 다양한 디저트 칵테일에 사용할 수 있습니다. ', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('초콜릿 시럽', 'Chocolate syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/056.초콜릿
시럽90.png', '초콜릿과 같은 맛이 나는 시럽. 초콜릿 시럽으로 만든 인기 있는 칵테일은 초콜릿 에스프레소 마티니입니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('계피 스틱', 'Cinnamon sticks', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/057.계피스틱80.png', '갈포과의 식물로서 나무의 껍질로 만들어 약간 매운 맛과 단맛을 동시에 갖는 향료. 칵테일 장식으로 계피 스틱이 사용됩니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('정향', 'Clove', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/058.정향80.png', '클로브라고
 불리는 정향나무의 꽃봉오리를 압착 건조한 정향은 맵고 향긋한 맛이 난다. 알코올의 강한 냄새를 억제한다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('커피 콩', 'Coffee beans', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/059.커피콩80.png', '커피나무의 씨앗으로 음용 커피의 재료. 에스프레소 마티니와 같은 음료의 장식을 사용된다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('아이스크림', 'Ice cream', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/060.아이스크림80.png', '우유, 설탕, 감미료로 만든 차가운 디저트. 칵테일에는 달콤하고 차가운 크림 질감을 더합니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('메이플 시럽', 'Maple syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/061.메이플시럽90.png', '사탕 단풍나무의 수액을 짜서 만든 달콤하고 어두운색의 시럽', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('라즈베리 시럽', 'Raspberry syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/062.라즈
베리시럽.png', '당밀에 나무딸기 라즈베리의 풍미를 가한 달콤하고 붉은색의 시럽', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('딸기', 'Strawberry', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/063.딸기80.png', '달콤
하고 새콤한 빨간색 과일로 칵테일 장식에 사용된다.', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('딸기 시럽', 'Strawberry syrup', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/064.딸기시럽
.png', '딸기로 만든 달콤한 시럽.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('레몬 주스', 'Lemon juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/065.레몬주스90.png', '레몬을 착즙하여 만든 주스', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('라임 주스', 'Lime juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/066.라임주스90.png', '라임을 착즙하여 만든 주스', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('스윗 앤 사워 믹스', 'Sweet sour mix', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/067.스
윗사워.png', '레몬주스, 라임주스 설탕으로 만들어 새콤달콤한 칵테일에 사용되는데 가루분말이거나 액상으로 되어있다. ', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('파워에이드', 'Powerade', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/068.파워에이드90.png', '코카콜라에서 개발한 무탄산 스포츠 음료로 1988년에 출시되었다. 비타민 B와 4가지 전해질 ION4가 함유되어 있어 몸에 물보다 빠른 흡수가 되는 것으로 유명하다', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('핫식스', 'HotSix', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/069.핫식스80.png', '핫식
스는 롯데칠성음료에서 제조 및 판매하는, 고카페인 에너지 음료이다. 외국에서 많이 판매되는 레드불이나 몬스터의 한국판 음료.', '음료수',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('팔각', 'Star anise', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/070.팔각80.png', '8개의
 꼭지점이 있는 별 모양 향신료. 목련과 상록수의 열매로 매콤하고 단맛나는데 칵테일에는 장식으로 사용된다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('복숭아 퓨레', 'Peach puree', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/071.복숭아퓨레90.png', '복숭아를 갈아서 부드럽게 만들어 칵테일에 걸죽한 질감과 복숭아 맛을 더해준다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('바나나', 'Banana', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/072.바나나90.png', '길쭉
하고 부드러운 달콤한 노란색 과일', '과일',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('코코넛 시럽', 'Coconut syrup ', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/073.코코넛시
럽.png', '코코넛 주스, 코코넛 플레이크 및 설탕의 혼합물을 끓여서 만든 달콤한 코코넛 맛 시럽. 칵테일에 달콤함과 코코넛 향을 더합니다.', '기타',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('석류 주스', 'Pomegranate juice', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/074.석류주
스.png', '석류의 즙을 내어 만든 붉은 주스', '주스',  null );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('압생트', 'Absinthe', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/046.압생트.png', '아니
스(Anis)씨와 감초 그리고 향쑥 약초와 향료를 원료로 배합하여 만든 리큐르로 일명 ‘녹색요정, 녹색의 마주’라고 한다. 감초 비슷한 맛과 오팔색을 띈다. 1700년대에 처음 만들어졌으며 1800년대 후반의 위대한 예술가와 작가들 사이
에서 인기와 명성을 얻었습니다. ', '강한도수',  '45' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('아페롤', 'Aperol', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/047.아페롤.png', '붉은 오
렌지색의 이탈리아 감귤 리큐르로 식전주로 만들어진 술이다. 아페롤 스프리츠가 유명하다. ', '약한도수',  '11' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('버터스카치 리큐르', 'Butterscotch liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/048.버터스카치.png', '버터와 흑설탕으로 만든 달콤하고 순한 리큐르로 보통 15~20% 정도의 알코올 도수입니다. ', '약한도수',  '15' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('바나나 리큐르', 'Banana liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/049.바나나
리큐르.png', '럼주 또는 기타 중성 증류주를 기본으로 하며 신선한 바나나와 설탕을 첨가하여 바나나맛이 나도록 만든 리큐르', '약한도수',  '25' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('칼바도스', 'Calvados', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/050.칼바도스.png', '
프랑스의 칼바도스 지역에서 생산되는 전통 증류주로 사과로 만드는 브랜디. 오크통에서 숙성되며 스모키한 뒷맛과 함께 매우 달콤한 사과 맛이 난다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('샤르트뢰즈 그린', 'Chartreuse green', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/051.샤
르트뢰즈그린.png', '130가지 허브와 식물, 꽃으로 숙성시킨 증류주로 만든 프랑스 리큐르. 샤르트뢰즈는 프랑스 그르노블 지역에 위치한 그랑 샤르트뢰즈 수도원의 이름을 따서 명명되었습니다.', '강한도수',  '55' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크림 드 카카오 브라운', 'Creme de cacao brown', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/052.카카오브라운.png', '카카오 열매와 바닐라 추출물을 증류하여 만든 달콤한 초콜릿 리큐르. 브라운은 화이트에 비해 더 다크하고 씁쓸하며 갈색의 시럽같은 질감이다.', '약한도수',  '25' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('크렘 드 민트 화이트', 'Creme de menthe white', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/053.민트화이트.png', '시원하고 부드러운 맛을 지닌 박하잎에서 추출한 농축액으로 만들어진 페퍼민트 리큐르로 화이트는 그린과 맛에서 구별되지않고 투명한 특성으로 칵테일의 색깔에 영향을 주지않고 상큼한 민트 맛을 내는데
사용한다.', '약한도수',  '24' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('듀보네', 'Dubonnet', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/054.듀보네.png', '허브
와 향신료를 첨가한 약한 키니네 맛을 가진 붉은색의 프랑스 식전주로 약한 단맛과 떫은맛이 나는 적포도주를 말한다.', '약한도수',  '14' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('계란 리큐르', 'Egg liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/055.계란리큐르.png', '브랜디를 베이스로 계란 노른자와 여러종류의 허브, 설탕을 배합하여 만든 리큐르. 바닐라향이 가미된 커스터드 향과 에그노그처럼 부드럽고 크림같은 질감이 특징으로 마시기전에 병을 잘 흔들어서 따른다.', '약한도수',  '17' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('프란젤리코', 'Frangelico', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/056.프란젤리코.png', '20% 도수의 헤이즐넛 리큐르로 맑은 갈색을 띄고 있다.', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('골드 럼', 'Gold rum', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/057.골드럼.png', '사탕
수수에서 설탕을 만들고 난 찌꺼지인 당밀(Molasses)를 이용하여 증류시켜 만든 증류주로 골드 럼은 앰버 럼으로도 불리며 연한 갈색에 깊은 맛이 특징이다. 2년간 태운 오크통에서 숙성되며 카라멜향과 바닐라, 너츠 등의 향미를 냅니
다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('골드슐라거', 'Goldschlager', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/058.골드슐라거.png', '금박기술자라는 뜻으로 금박이 들어있는 높은 도수의 스위스 계피 리큐르', '강한도수',  '43' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('헤네시', 'Hennessy', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/059.헤네시.png', '헤네
시는 유명 꼬냑 제조사이며 오래 숙성시킨 원액을 100여가지 이상 혼합하여 독특한 맛과 향을 더한다. ', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('힙노틱', 'Hpnotiq', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/060.힙노틱.png', '최면에
 빠진이라는 뜻으로 보드카, 꼬냑 및 과일주스로 만든 리큐르. 여러가지 과일맛이 조화롭고 알콜향이 강하지않다.', '약한도수',  '17' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('아이리쉬 스타우트', 'Irish stout', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/061.아이
리쉬스타우트90.png', '아일랜드에서 주로 생산되는 스타우트로 볶은 맥아 또는 보리, 홉, 효모 및 물로 만든 어두운 맥주입니다. 기네스가 유명하다.', '약한도수',  '4' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('릴레블랑', 'Lillet Blanc', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/062.릴레블랑.png', '릴레브론드로 불리는 프랑스 식전주. 와인과 과일 향이 절묘하게 섞여있어 은은한 꽃향기와 달콤한 오렌지향이 난다. ', '약한도수',  '17' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('마라스키노 리큐르', 'Maraschino liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/063.마라스키노리큐르.png', '마라스카종의 체리를 사용하여 발효시키고 세번을 증류하여 숙성시킨 후 시럽 등을 첨가하여 만든 체리맛의 리큐르', '약한도수',  '32' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('올드 톰 진', 'Old Tom Gin', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/064.올드톰진.png', '18세기 영국에서 인기를 얻은 올드 톰 진은 약간의 설탕 덕분에 드라이 진보다 조금 더 달콤합니다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('피스코', 'Pisco', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/065.피스코.png', '페루 또
는 칠레의 포도 브랜디로 증류를 마친 뒤 브랜디에 색이 물들지않도록 백색처리를 한 오크통에서 숙성한다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('삼부카', 'Sambuca', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/066.삼부카.png', '아니스
(Anis) 및 여러 가지 부재료가 사용되었으며 스텐레스통에서 숙성시켜 만든 무색 투명한 리큐르. 이탈리아에서는 엘더베리를 삼부카 니그라(Sambuca Nigra)라고 불러 이름을 따왔습니다.', '강한도수',  '38' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('슬로 진', 'Sloe gin', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/067.슬로진.png', '유럽
에서 많이 자라는 야생자두(Sloe berry, 오얏나무의 열매)를 진에 침지하여 주니퍼베리의 향을 첨가하고 설탕을 더해 만든 리큐르', '강한도수',  '25' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('서던 컴포트', 'Southern comfort', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/068.서던컴
포트.png', '버번위스키에 복숭아 향미를 첨가한 리큐르로 미국을 대표한다.', '약한도수',  '35' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('스파클링 와인', 'Sparkling wine', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/069.스파클
링와인.png', '발포성와인으로 발효 도중에 생기는 탄산가스를 함유한 와인이다. 샴페인은 가장 잘 알려진 스파클링 와인이며 프랑스 샴페인 지역에서만 만들어집니다. ', '약한도수',  '12' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('데킬라 골드', 'Tequila gold', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/070.데킬라골드
.png', '데킬라는 용설란의 일종으로 멕시코 데킬라 지방에서만 재배되는 아가베로 만든 술로 골드 데킬라는 이중 증류와 오크통에서 숙성시키는 특징이 있다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('트리플 섹', 'Ttriple sec', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/071.트리플섹.png', '오렌지 껍질, 브랜디, 설탕을 원료로 한 달콤하고 무색의 오렌지 리큐르로, 3번의 증류를 거듭했다는 뜻에서 나온 이름이다. ', '약한도수',  '20' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('레몬 리큐르', 'Lemon liqueur', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/072.레몬리큐
르.png', '이탈리아 아말피 해안의 스푸사토 품종의 레몬을 사용하여 만든 레몬리큐르로 리몬첼로라 불린다. 스푸사토는 껍질이 두꺼워 산도가 낮고 향이 풍부한 것이 특징이다.', '약한도수',  '26' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('아이리쉬 위스키', 'Irish whiskey', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/073.아이
리쉬위스키.png', '아일랜드에서 만들어지는 위스키의 총칭으로 세 번 증류하고 맥아 건조 과정에서 피트를 쓰지 않음으로써 전통적인 스카치 위스키나 버번 위스키보다 마시기 쉽고 익숙해지기 쉬운 맛을 구현했다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('샤르트뢰즈 옐로우', 'Chartreuse yellow', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/074.샤르트뢰즈옐로우.png', '130가지 허브와 식물, 꽃으로 숙성시킨 증류주로 만든 프랑스 리큐르. 샤르트뢰즈는 프랑스 그르노블 지역에 위치한 그랑 샤르트뢰즈 수도원의 이름을 따서 명명되었습니다. 옐로우 샤르트뢰즈는 그린 샤르트
뢰즈보다 더 순하며 달콤합니다.', '강한도수',  '40' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('소주', 'Soju', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/075.soju90.png', '곡류를 발효
시켜 증류하거나, 알코올을 물로 희석하여 만든 한국의 전통주 중 하나. 국내에서는 저렴한 술이지만 해외에서는 고가로 판매되며 제조 방법에 따라 희석식 소주, 증류식 소주로 구분됩니다.', '약한도수',  '17' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('막걸리', 'Makgeolli', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/076.막걸리.png', '우리
나라 고유한 술의 하나. 맑은 술을 떠내지않고 그대로 걸러 짠 술로 빛깔이 흐리고 맛이 텁텁하다. 과음을 하고 나면 다음날 숙취가 심합니다.', '약한도수',  '6' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('백세주', 'Baekseju', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/077.백세주90.png', '찹
쌀로 만든 한국의 발효술로 전통적인 방식으로 양조하며 다양한 허브, 미량의 인삼을 넣어 감미로운 맛을 낸다. 백세주라는 이름은 이 술을 마시면 백세까지도 살 수 있다해서 붙여졌다.', '약한도수',  '13' );
INSERT INTO momol.ingredient (ing_name, ing_name_eng, ing_photo, ing_detail, ing_categ, abv) VALUES ('산사춘', 'Sansachun', 'https://cocktail-bucket.s3.ap-northeast-2.amazonaws.com/TB_ITEM_MASTER/078.산산춘90.png', '쌀
을 주원료로 하여 산사나무와 산수유 열매로 향과 맛의 깊이를 더했다. 은은한 과실향에 새콤한 맛이 미각을 살려준다.', '약한도수',  '13' );


/* 칵테일별 재료 레코드 */

use momol;
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '애플 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '사과'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '애플 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '애플 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '사과 리큐르'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '애플 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '애플 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '40ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'B-52', (SELECT ing_num FROM ingredient WHERE ing_name = '베일리스'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'B-52', (SELECT ing_num FROM ingredient WHERE ing_name = '그랑 마니에르'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'B-52', (SELECT ing_num FROM ingredient WHERE ing_name = '칼루아'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '바카디 칵테일', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '바카디 칵테일', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '바카디 칵테일', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '바카디 칵테일', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블랙 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블랙 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '커피 리큐르'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블랙 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '후추'), '1dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '샐러리'), '1stalk';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1quarter';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '소금'), '1dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '타바스코'), '1dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '토마토 주스'), '90ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '우스터 소스'), '2dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블러디 메리', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블로우 잡', (SELECT ing_num FROM ingredient WHERE ing_name = '휘핑 크림'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블로우 잡', (SELECT ing_num FROM ingredient WHERE ing_name = '아마레토'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블로우 잡', (SELECT ing_num FROM ingredient WHERE ing_name = '베일리스'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '200gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플'), '1wedge';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플 주스'), '90ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '블루 큐라소'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 하와이', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 카미카제', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 카미카제', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '2slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 카미카제', (SELECT ing_num FROM ingredient WHERE ing_name = '블루 큐라소'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 카미카제', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 라군', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 라군', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1wedge';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 라군', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬에이드'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 라군', (SELECT ing_num FROM ingredient WHERE ing_name = '블루 큐라소'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 라군', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 오션', (SELECT ing_num FROM ingredient WHERE ing_name = '자몽 주스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 오션', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 오션', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 오션', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 오션', (SELECT ing_num FROM ingredient WHERE ing_name = '블루 큐라소'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '블루 오션', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'BMW', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'BMW', (SELECT ing_num FROM ingredient WHERE ing_name = '베일리스'), '45ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'BMW', (SELECT ing_num FROM ingredient WHERE ing_name = '말리부 코코넛 럼'), '45ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT 'BMW', (SELECT ing_num FROM ingredient WHERE ing_name = '위스키'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보일러 메이커', (SELECT ing_num FROM ingredient WHERE ing_name = '맥주'), '400ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보일러 메이커', (SELECT ing_num FROM ingredient WHERE ing_name = '위스키'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브랜디 에그노그', (SELECT ing_num FROM ingredient WHERE ing_name = '계란'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브랜디 에그노그', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브랜디 에그노그', (SELECT ing_num FROM ingredient WHERE ing_name = '우유'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브랜디 에그노그', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브랜디 에그노그', (SELECT ing_num FROM ingredient WHERE ing_name = '넛맥'), '2gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브랜디 에그노그', (SELECT ing_num FROM ingredient WHERE ing_name = '브랜디'), '40ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브롱크스', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브롱크스', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브롱크스', (SELECT ing_num FROM ingredient WHERE ing_name = '드라이 베르무트'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브롱크스', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '브롱크스', (SELECT ing_num FROM ingredient WHERE ing_name = '스위트 베르무트'), '15ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '코스모폴리탄', (SELECT ing_num FROM ingredient WHERE ing_name = '크랜베리 주스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '코스모폴리탄', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '코스모폴리탄', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '코스모폴리탄', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '코스모폴리탄', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카 시트론'), '40ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '쿠바 리브레', (SELECT ing_num FROM ingredient WHERE ing_name = '콜라'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '쿠바 리브레', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '쿠바 리브레', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '쿠바 리브레', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '다이키리', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '다이키리', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '다이키리', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '다이키리', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '더티 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '더티 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '올리브'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '더티 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '올리브 주스'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '더티 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '드라이 베르무트'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '더티 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에스프레소 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '커피'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에스프레소 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에스프레소 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에스프레소 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '칼루아'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에스프레소 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '깁슨', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '깁슨', (SELECT ing_num FROM ingredient WHERE ing_name = '방울양파'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '깁슨', (SELECT ing_num FROM ingredient WHERE ing_name = '드라이 베르무트'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '깁슨', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '김렛', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '50gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '김렛', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '김렛', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '김렛', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '탄산수'), '80ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1wedge';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '토닉워터'), '100ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '진토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '갓파더', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '갓파더', (SELECT ing_num FROM ingredient WHERE ing_name = '아마레토'), '35ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '갓파더', (SELECT ing_num FROM ingredient WHERE ing_name = '스카치 위스키'), '35ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '갓마더', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '갓마더', (SELECT ing_num FROM ingredient WHERE ing_name = '아마레토'), '35ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '갓마더', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '35ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '골드 러쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '꿀 시럽'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '골드 러쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '골드 러쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '2개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '골드 러쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '버번 위스키'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그래스호퍼', (SELECT ing_num FROM ingredient WHERE ing_name = '크림'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그래스호퍼', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그래스호퍼', (SELECT ing_num FROM ingredient WHERE ing_name = '민트'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그래스호퍼', (SELECT ing_num FROM ingredient WHERE ing_name = '크림 드 카카오 화이트'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그래스호퍼', (SELECT ing_num FROM ingredient WHERE ing_name = '크렘 드 민트 그린'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그린 멕시칸', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그린 멕시칸', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그린 멕시칸', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '45ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그린 멕시칸', (SELECT ing_num FROM ingredient WHERE ing_name = '미도리'), '90ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '그린 멕시칸', (SELECT ing_num FROM ingredient WHERE ing_name = '데킬라 블랑코'), '90ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하비 월뱅어', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하비 월뱅어', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하비 월뱅어', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하비 월뱅어', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '90ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하비 월뱅어', (SELECT ing_num FROM ingredient WHERE ing_name = '갈리아노'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하비 월뱅어', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하이볼', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하이볼', (SELECT ing_num FROM ingredient WHERE ing_name = '탄산수'), '150ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '하이볼', (SELECT ing_num FROM ingredient WHERE ing_name = '위스키'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '꿀'), '1teaspoon';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '물'), '100ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '위스키'), '45ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '계피 스틱'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '정향'), '3개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '핫 토디', (SELECT ing_num FROM ingredient WHERE ing_name = '팔각'), '1개';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '패션프루트 주스'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '다크 럼'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '오버프루프 럼'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '허리케인', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '잭콕', (SELECT ing_num FROM ingredient WHERE ing_name = '콜라'), '150ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '잭콕', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '잭콕', (SELECT ing_num FROM ingredient WHERE ing_name = '잭 다니엘'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '예거밤', (SELECT ing_num FROM ingredient WHERE ing_name = '레드불'), '125ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '예거밤', (SELECT ing_num FROM ingredient WHERE ing_name = '예거 마이스터'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '젤리피쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '4drops';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '젤리피쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '아마레토'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '젤리피쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '베일리스'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '젤리피쉬', (SELECT ing_num FROM ingredient WHERE ing_name = '크림 드 카카오 화이트'), '25ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '키르', (SELECT ing_num FROM ingredient WHERE ing_name = '크림 드 카시스'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '키르', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 와인'), '90ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '민트'), '2leaves';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플 주스'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '패션프루트 주스'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '살구 브랜디'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '레이디킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '앙고스투라 비터'), '2dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '자몽'), '1twist';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '드라이 셰리'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '런던콜링', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '콜라'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '데킬라 블랑코'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '롱아일랜드 아이스티', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '15ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '아몬드 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '8ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '다크 럼'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 큐라소'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마이타이', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '맨하탄', (SELECT ing_num FROM ingredient WHERE ing_name = '앙고스투라 비터'), '1dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '맨하탄', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '맨하탄', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '맨하탄', (SELECT ing_num FROM ingredient WHERE ing_name = '라이 위스키'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '맨하탄', (SELECT ing_num FROM ingredient WHERE ing_name = '스위트 베르무트'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마가리타', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마가리타', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마가리타', (SELECT ing_num FROM ingredient WHERE ing_name = '소금'), '2gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마가리타', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마가리타', (SELECT ing_num FROM ingredient WHERE ing_name = '데킬라 블랑코'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '올리브'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '드라이 베르무트'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '미도리 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '110gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '미도리 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '미도리 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '미도리 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '미도리'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모히또', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모히또', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모히또', (SELECT ing_num FROM ingredient WHERE ing_name = '민트'), '6springs';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모히또', (SELECT ing_num FROM ingredient WHERE ing_name = '탄산수'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모히또', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕'), '2teaspoon';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모히또', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모스코 뮬', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모스코 뮬', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모스코 뮬', (SELECT ing_num FROM ingredient WHERE ing_name = '진저 비어'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '모스코 뮬', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '머드슬라이드', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '50gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '머드슬라이드', (SELECT ing_num FROM ingredient WHERE ing_name = '베일리스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '머드슬라이드', (SELECT ing_num FROM ingredient WHERE ing_name = '커피 리큐르'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '머드슬라이드', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '네그로니', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '네그로니', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '네그로니', (SELECT ing_num FROM ingredient WHERE ing_name = '캄파리'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '네그로니', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '네그로니', (SELECT ing_num FROM ingredient WHERE ing_name = '스위트 베르무트'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '뉴욕 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '계란'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '뉴욕 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '뉴욕 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '뉴욕 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '20ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '뉴욕 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '레드 와인'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '뉴욕 사워', (SELECT ing_num FROM ingredient WHERE ing_name = '라이 위스키'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '앙고스투라 비터'), '2dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 비터'), '4dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕'), '1cube';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '물'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '올드 패션드', (SELECT ing_num FROM ingredient WHERE ing_name = '라이 위스키'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '오르가즘', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '오르가즘', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '오르가즘', (SELECT ing_num FROM ingredient WHERE ing_name = '베일리스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '오르가즘', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '오르가즘', (SELECT ing_num FROM ingredient WHERE ing_name = '그랑 마니에르'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '페인킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '코코넛 밀크'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '페인킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '페인킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '페인킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플 주스'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '페인킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '넛맥'), '1gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '페인킬러', (SELECT ing_num FROM ingredient WHERE ing_name = '다크 럼'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '코코넛 크림'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플'), '1wedge';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플 주스'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '화이트 럼'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '크림'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '계란'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '라임'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 플라워 워터'), '3dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '탄산수'), '25ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕 시럽'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '바닐라 추출액'), '2drops';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '라모스 피즈', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '러스티 네일', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '러스티 네일', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1twist';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '러스티 네일', (SELECT ing_num FROM ingredient WHERE ing_name = '드람부이'), '25ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '러스티 네일', (SELECT ing_num FROM ingredient WHERE ing_name = '스카치 위스키'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '탄산수'), '200ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕'), '20gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '브랜디'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '샹그리아', (SELECT ing_num FROM ingredient WHERE ing_name = '레드 와인'), '750ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '스크류드라이버', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '스크류드라이버', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '스크류드라이버', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '100ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '스크류드라이버', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '씨 브리즈', (SELECT ing_num FROM ingredient WHERE ing_name = '크랜베리 주스'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '씨 브리즈', (SELECT ing_num FROM ingredient WHERE ing_name = '자몽 주스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '씨 브리즈', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '씨 브리즈', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '씨 브리즈', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '씨 브리즈', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '40ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '섹스온더비치', (SELECT ing_num FROM ingredient WHERE ing_name = '크랜베리 주스'), '40ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '섹스온더비치', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '섹스온더비치', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '섹스온더비치', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '40ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '섹스온더비치', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '40ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '섹스온더비치', (SELECT ing_num FROM ingredient WHERE ing_name = '복숭아 리큐르'), '20ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '사이드 카', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '사이드 카', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '사이드 카', (SELECT ing_num FROM ingredient WHERE ing_name = '설탕'), '10gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '사이드 카', (SELECT ing_num FROM ingredient WHERE ing_name = '꼬냑'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '사이드 카', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '실버 불렛', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '실버 불렛', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1twist';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '실버 불렛', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '실버 불렛', (SELECT ing_num FROM ingredient WHERE ing_name = '스카치 위스키'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '앙고스투라 비터'), '1dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1half';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플 주스'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '베네딕틴 D.O.M'), '7ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '체리 브랜디'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '쿠앵트로'), '7ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '싱가포르 슬링', (SELECT ing_num FROM ingredient WHERE ing_name = '진'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '데킬라 선라이즈', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '데킬라 선라이즈', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '데킬라 선라이즈', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '데킬라 선라이즈', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '데킬라 선라이즈', (SELECT ing_num FROM ingredient WHERE ing_name = '오렌지 주스'), '90ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '데킬라 선라이즈', (SELECT ing_num FROM ingredient WHERE ing_name = '데킬라 블랑코'), '45ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보드카 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보드카 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1peel';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보드카 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '올리브'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보드카 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '드라이 베르무트'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '보드카 마티니', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '55ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '화이트 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '크림'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '화이트 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '화이트 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '커피 리큐르'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '화이트 러시안', (SELECT ing_num FROM ingredient WHERE ing_name = '보드카'), '50ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '꿀주', (SELECT ing_num FROM ingredient WHERE ing_name = '맥주'), '3ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '꿀주', (SELECT ing_num FROM ingredient WHERE ing_name = '소주'), '27ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에너자이저주', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에너자이저주', (SELECT ing_num FROM ingredient WHERE ing_name = '파워에이드'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에너자이저주', (SELECT ing_num FROM ingredient WHERE ing_name = '핫식스'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '에너자이저주', (SELECT ing_num FROM ingredient WHERE ing_name = '소주'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '고진감래주', (SELECT ing_num FROM ingredient WHERE ing_name = '콜라'), '15ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '고진감래주', (SELECT ing_num FROM ingredient WHERE ing_name = '맥주'), '50ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '고진감래주', (SELECT ing_num FROM ingredient WHERE ing_name = '소주'), '15ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '한라토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '한라토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬'), '1slice';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '한라토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '토닉워터'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '한라토닉', (SELECT ing_num FROM ingredient WHERE ing_name = '소주'), '30ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '로이 로저스', (SELECT ing_num FROM ingredient WHERE ing_name = '콜라'), '200ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '로이 로저스', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '10ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '로이 로저스', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '로이 로저스', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '셜리 템플', (SELECT ing_num FROM ingredient WHERE ing_name = '그레나딘 시럽'), '1dash';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '셜리 템플', (SELECT ing_num FROM ingredient WHERE ing_name = '레몬에이드'), '60ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '셜리 템플', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '셜리 템플', (SELECT ing_num FROM ingredient WHERE ing_name = '진저 에일'), '60ml';


INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '버진 피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '코코넛 밀크'), '30ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '버진 피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '얼음'), '100gram';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '버진 피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '마라스키노 체리'), '1개';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '버진 피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플'), '1wedge';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '버진 피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '파인애플 주스'), '120ml';
INSERT INTO momol.cock_ingre (`name`, `ing_num`, `ing_amount`) SELECT '버진 피나 콜라다', (SELECT ing_num FROM ingredient WHERE ing_name = '휘핑 크림'), '30ml';
