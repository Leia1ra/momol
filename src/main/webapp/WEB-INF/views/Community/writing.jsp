<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/Community/style.css" type="text/css">
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
</head>
<body>
<main>
    <h2>글쓰기</h2>
    <form method="post" action="<%=request.getContextPath()%>/community/posting" id="posting" onsubmit="return validate();">

        <div class="boardselect">
            <select name="Catnum" id="Catnum">
                <option value="0">게시판을 선택해 주세요</option>
                <option value="1">담벼락</option>
                <option value="2">추천해 주세요</option>
                <option value="3">다녀왔습니다</option>
                <option value="4">나만의 레시피</option>
                <option value="5">위시리스트</option>
            </select>
        </div>

        <div class="title"><input type="text" name="title" placeholder="제목을 입력해 주세요"></div>

        <!-- CKEditor -->
        <textarea name="Content" id="editor"></textarea>

        <!-- UploadAdapter 클래스 정의 -->
        <script>
            class UploadAdapter {
                constructor(loader) {
                    this.loader = loader;
                }

                upload() {
                    return this.loader.file.then( file => new Promise(((resolve, reject) => {
                        this._initRequest();
                        this._initListeners( resolve, reject, file );
                        this._sendRequest( file );
                    })));
                }

                _initRequest() {
                    const xhr = this.xhr = new XMLHttpRequest();
                    xhr.open('POST', 'http://localhost:8080/community/imgs/upload', true);
                    xhr.responseType = 'json';
                }

                _initListeners(resolve, reject, file) {
                    const xhr = this.xhr;
                    const loader = this.loader;
                    const genericErrorText = '파일을 업로드 할 수 없습니다.';

                    xhr.addEventListener('error', () => {reject(genericErrorText);});
                    xhr.addEventListener('abort', () => reject());
                    xhr.addEventListener('load', () => {
                        const response = xhr.response;
                        if(!response || response.error) {
                            return reject( response && response.error ? response.error.message : genericErrorText );
                        }

                        resolve({
                            default: response.url //업로드된 파일 주소
                        });
                    });
                }

                _sendRequest(file) {
                    const data = new FormData();
                    data.append('upload', file);
                    this.xhr.send(data);
                }
            }
        </script>

        <script>
            ClassicEditor
                .create( document.querySelector( '#editor' ), {
                    extraPlugins: [MyCustomUploadAdapterPlugin],
                })
                .catch( error => {
                    console.error( error );
                });

            function MyCustomUploadAdapterPlugin(editor) {
                editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                    return new UploadAdapter(loader);
                };
            }
        </script>

        <input type="hidden" name="UID" VALUE="asdads">

        <div class="btns">
            <a id="canclebtn" href="javascript:history.back()">취소</a>
            <input type="submit" id="confirmbtn" value="등록">
        </div>

        <script>
            function validate() {
                var catnumValue = document.getElementById('Catnum').value;

                if (catnumValue == 0) {
                    alert('카테고리를 지정해 주세요.');
                    return false;
                }
                return true;
            }
        </script>
    </form>
</main>
</body>
</html>
