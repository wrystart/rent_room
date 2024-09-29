import { IUserData } from '../models/UserData';
import { http } from '../utils/http';

interface IResponse {
  token: string
}


// 发送验证码
export const sendSMSCodeApi = (phone: string): Promise<null> => {
  return http.post<null>('/sendSMSCode', { phone })
}

// 登录
export const loginApi = (phone: string, code: string): Promise<IResponse> => {
  return http.post<IResponse>('/login', { phone, code })
}

// 查询用户信息
export const getUserInfoApi = (): Promise<IUserData> => {
  return http.get<IUserData>('/auth/user/userInfo')
}