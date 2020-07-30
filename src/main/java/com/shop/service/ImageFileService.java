package com.shop.service;

import com.shop.model.ImageFiles;

public interface ImageFileService {
	
	void save(ImageFiles files);
	void delete(long id);
	ImageFiles findById(long id);

}
