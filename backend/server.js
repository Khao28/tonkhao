const express = require('express');
const app = express();

require('dotenv').config();  // โหลดค่าจาก .env


const authRoutes = require('./routes/authRoutes');
const assetRoutes = require('./routes/assetRoutes');
const borrowRoutes = require('./routes/borrowRoutes'); 
const approverRoutes = require('./routes/approverRoutes'); 

app.use(express.json());

app.use('/auth', authRoutes);
app.use('/assets', assetRoutes);
app.use('/requests', borrowRoutes);
app.use('/approver', approverRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
