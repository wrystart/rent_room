import { http } from '../utils/http';
import { IServiceData } from '../models/ServiceData';

// 获取服务页数据
export const getServiceDataApi = (): Promise<IServiceData> => {
  return http.get<IServiceData>('/service/info')
}