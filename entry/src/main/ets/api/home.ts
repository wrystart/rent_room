import { http } from '../utils/http';
import type { IHomeData } from '../models/HomeData';

// 获取首页数据
export const getHomeDataApi = () => {
  return http.get<IHomeData>('/home/info')
}

