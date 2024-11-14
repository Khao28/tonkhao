const db = require('../config/db');  
const createAsset = require('../models/Asset');

// ฟังก์ชันสร้างสินทรัพย์ใหม่
exports.createAsset = (req, res) => {
    const { name, description, status } = req.body;
    
    if (!name || !status) {
      return res.status(400).json({ message: 'Name and status are required' });
    }
  
    // สมมุติฐานข้อมูล
    const query = 'INSERT INTO assets (name, description, status) VALUES (?, ?, ?)';
    db.query(query, [name, description, status], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Database error' });
      }
      res.status(201).json({ message: 'Asset created successfully', assetId: result.insertId });
    });
  };
  
  // ฟังก์ชันดึงข้อมูลสินทรัพย์ทั้งหมด
  exports.getAllAssets = (req, res) => {
    const query = 'SELECT * FROM assets';
    db.query(query, (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Database error' });
      }
      res.status(200).json(results);
    });
  };
  
  // ฟังก์ชันอัพเดตสถานะสินทรัพย์
  exports.updateAssetStatus = (req, res) => {
    const { id } = req.params;
    const { status } = req.body;
  
    if (!status) {
      return res.status(400).json({ message: 'Status is required' });
    }
  
    const query = 'UPDATE assets SET status = ? WHERE id = ?';
    db.query(query, [status, id], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Database error' });
      }
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Asset not found' });
      }
      res.status(200).json({ message: 'Asset status updated successfully' });
    });
  };
  
  // ฟังก์ชันคืนสินทรัพย์
  exports.returnAsset = (req, res) => {
    const { id } = req.params;
  
    const query = 'SELECT * FROM assets WHERE id = ?';
    db.query(query, [id], (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Database error' });
      }
  
      if (results.length === 0) {
        return res.status(404).json({ message: 'Asset not found' });
      }
  
      const asset = results[0];
      if (asset.status === 'borrowed') {
        const updateQuery = 'UPDATE assets SET status = "available" WHERE id = ?';
        db.query(updateQuery, [id], (updateErr, updateResult) => {
          if (updateErr) {
            console.error(updateErr);
            return res.status(500).json({ message: 'Error updating asset status' });
          }
          res.status(200).json({ message: 'Asset returned successfully and status updated to available' });
        });
      } else {
        return res.status(400).json({ message: 'Asset is not in borrowed status' });
      }
    });
  };
  