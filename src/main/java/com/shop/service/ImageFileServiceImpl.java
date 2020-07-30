package com.shop.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.model.ImageFiles;
import com.shop.repository.ImageRepository;

@Transactional
@Service
public class ImageFileServiceImpl implements ImageFileService {

	@Autowired
	private ImageRepository imageRepository;
	
	@Override
	public void save(ImageFiles files) {
		imageRepository.save(files);
	}

	@Override
	public void delete(long id) {
		imageRepository.deleteById(id);
	}

	@Override
	public ImageFiles findById(long id) {
		return imageRepository.findById(id).get();
	}

}
