<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 유형 선택</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Center content vertically */
        }

        .form-container {
            max-width: 800px;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .form-container h2 {
            margin-bottom: 20px;
        }

        .radio-group {
            margin-bottom: 20px;
        }

        .radio-group input[type="radio"] {
            display: none; /* Hide default radio button */
        }

        .radio-group label {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 10px;
            border: 2px solid #4CAF50;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            color: #4CAF50;
            transition: background-color 0.3s, color 0.3s;
        }

        .radio-group input[type="radio"]:checked + label {
            background-color: #4CAF50;
            color: white;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>사용자 유형 선택</h2><br><br>
        <form>
            <div class="radio-group">
                <input type="radio" id="regularUser" name="userType" value="regular" required>
                <label for="regularUser">일반 사용자</label>
                
                <input type="radio" id="adminUser" name="userType" value="admin">
                <label for="adminUser">관리자</label>
            </div>
            
            <button type="button" onclick="window.open('join.html')" class="btn">확인</button>
        </form>
    </div>
</body>
</html>
