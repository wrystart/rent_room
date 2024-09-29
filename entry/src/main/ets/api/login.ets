import { http } from '../utils/http';

// 发送验证码
export const sendSMSCodeApi = (phone: string): Promise<null> => {
  return http.post<null>('sendSMSCode', { phone })
}